import 'dart:developer' as dev;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

const SIGNATURE_TIMESTAMP_TOLERANCE_GW = 60 * 60 * 2; // 2h

/// Contains the status information of a vocdoni-node gateway
class DVoteGatewayStatus {
  int health;
  List<String> supportedApis;
  bool isUp;
  DVoteGatewayStatus(this.isUp, this.health, this.supportedApis);
}

class VochainStats {
  int blockHeight;
  int entityCount;
  int envelopeCount;
  int processCount;
  int transactionCount;
  int validatorCount;
  List<int> blockTime;
  int blockTimeStamp;
  String chainId;
  String genesisTimeStamp;
  bool syncing;

  VochainStats({
    this.blockHeight = 0,
    this.entityCount = 0,
    this.envelopeCount = 0,
    this.processCount = 0,
    this.transactionCount = 0,
    this.validatorCount = 0,
    required this.blockTime,
    this.blockTimeStamp = 0,
    this.chainId = "",
    this.genesisTimeStamp = "",
    this.syncing = false,
  });
}

class VochainProcess {
  String id;
  String entityId;
  // int entityIndex;
  // int startBlock;
  // int endBlock;
  // int rheight;
  // String censusRoot;
  // String censusUri;
  String metadata;
  int censusOrigin;
  int status;
  // int namespace;
  // Map<String, dynamic> envelope;
  // Map<String, dynamic> mode;
  // Map<String, dynamic> voteOpts;
  // List<String> privateKeys;
  // List<String> publicKeys;
  // int questionIndex;
  String creationTime;
  bool haveResults;
  bool finalResults;
  int sourceBlockHeight;
  String sourceNetworkId;

  VochainProcess(
      {this.id = "",
      this.entityId = "",
      this.metadata = "",
      this.censusOrigin = 0,
      this.status = 0,
      this.creationTime = "",
      this.haveResults = false,
      this.finalResults = false,
      this.sourceBlockHeight = 0,
      this.sourceNetworkId = ""});
}

/// Client class to send HTTP requests to a DVote Gateway
class DVoteGateway {
  late String _gatewayUri;
  late final String? publicKey;
  late int _health;
  late List<String> _supportedApis;

  String get uri => _gatewayUri;
  int get health => _health;
  List<String> get supportedApis => _supportedApis;

  /// Creates a new DVoteGateway instance.
  /// NOTE: URI's using the websocket protocol will be rewritten into using http/s
  DVoteGateway(String gatewayUri, {this.publicKey}) {
    this._gatewayUri = gatewayUri.startsWith("ws")
        ? gatewayUri.replaceFirst("ws", "http")
        : gatewayUri;
    this._health = 0;
    this._supportedApis = [];
  }

  /// Perform a raw request to the Vocdoni Gateway and wait for a response to
  /// arrive within a given timeout
  Future<Map<String, dynamic>> sendRequest(Map<String, dynamic> body,
      {int timeout = 20}) async {
    final id = makeRandomId();

    final comp = Completer<Map<String, dynamic>>();

    final Map<String, dynamic> requestBody = Map.from(body);
    if (!(requestBody["timestamp"] is int)) {
      requestBody["timestamp"] = getTimestampForGateway();
    }

    Map<String, dynamic> requestPayload = {
      "id": id,
      // Important: Sorting the JSON data itself, the same way that it will be signed later on
      "request": sortJsonFields(requestBody),
      "signature": ""
    };

    // Launch the request and report the result if not already completed
    http
        .post(
          Uri.parse(_gatewayUri),
          body: jsonEncode(requestPayload),
          headers: {"Content-Type": "application/json"},
        )
        .then((response) => this._digestResponse(response, comp, id))
        .catchError((err) {
          dev.log("[Gateway] Response error from $_gatewayUri: $err");
          if (!comp.isCompleted) comp.completeError(err);
        });

    // Trigger a timeout after N seconds
    Future.delayed(Duration(seconds: timeout)).then((_) {
      if (comp.isCompleted) return;
      comp.completeError(TimeoutException("Time out"));
    });

    return comp.future;
  }

  Future<void> _digestResponse(
      http.Response response, Completer comp, String requestId) async {
    // Already handled?
    if (comp.isCompleted) {
      throw Exception("Got a response for an already completed (timed out)");
    }

    Map<String, dynamic> decodedMessage;
    try {
      decodedMessage = jsonDecode(response.body);
    } catch (err) {
      throw Exception("Received a non-JSON message");
    }

    if (!(decodedMessage is Map)) {
      throw Exception("Received an invalid response");
    }

    final nowTimestampBase = getTimestampForGateway();
    final signatureValidFrom =
        nowTimestampBase - SIGNATURE_TIMESTAMP_TOLERANCE_GW;
    final signatureValidUntil =
        nowTimestampBase + SIGNATURE_TIMESTAMP_TOLERANCE_GW;

    final String givenId = decodedMessage["id"];
    final Map<String, dynamic> jsonResponse = decodedMessage["response"];

    // Check the response field
    if (givenId != requestId)
      throw Exception("Received a different request ID");
    else if (jsonResponse is! Map)
      throw Exception("Received an invalid response");
    else if (givenId != jsonResponse["request"])
      throw Exception("The signed request ID does not match the expected one");
    else if (!(jsonResponse["timestamp"] is int) ||
        jsonResponse["timestamp"] < signatureValidFrom ||
        jsonResponse["timestamp"] > signatureValidUntil) {
      throw Exception("The response timestamp is invalid");
    }

    if (jsonResponse["ok"] is! bool || jsonResponse["ok"] != true) {
      throw Exception(jsonResponse["message"] is String
          ? jsonResponse["message"]
          : "The request failed");
    }

    // Already handled? (2)
    if (comp.isCompleted) {
      throw Exception("Got a response for an already completed (timed out)");
    }

    comp.complete(jsonResponse);
  }
}

/// RANDOM

final _random = Random.secure();

/// Returns a base64 representation of a random buffer of the given size
String makeRandomId([int byteCount = 16]) {
  final values = List<int>.generate(byteCount, (i) => _random.nextInt(256));
  return base64.encode(values);
}

/// Signatures need to be computed over objects that can be 100% reproduceable.
/// Since the ordering is not guaranteed, this function returns a recursively
/// ordered map
dynamic sortJsonFields(dynamic data) {
  if (!(data is Map) && !(data is List))
    return data;
  else if (data is List) {
    return data.map((item) => sortJsonFields(item)).cast().toList();
  }

  final keys = <String>[];
  final result = Map<String, dynamic>();

  data.forEach((k, v) {
    keys.add(k);
  });
  keys.sort((String a, String b) => a.compareTo(b));
  keys.forEach((k) {
    result[k] = sortJsonFields(data[k]);
  });
  return result;
}

/// Returns a timestamp in seconds, as expected by the Gateway
int getTimestampForGateway() {
  return (DateTime.now().millisecondsSinceEpoch / 1000).floor();
}
