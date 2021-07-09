import 'package:explorer_flutter_prototype/net/gateway.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<DVoteGateway> useGatewayPool() {
  // Initialize value notifier with empty gateway pool
  ValueNotifier<DVoteGateway> dVoteGatewayNotifier =
      ValueNotifier(DVoteGateway("https://gw1.vocdoni.net/dvote"));
  return dVoteGatewayNotifier;
}

ValueNotifier<DVoteGatewayStatus?> useGwStatus() {
  final DVoteGatewayStatus? status = null;
  final gwStatusNotifier = useState(status);
  useEffect(() {
    final req = {"method": "getInfo", "timestamp": getTimestampForGateway()};
    useGatewayPool().value.sendRequest(req).then((result) {
      if (result["apiList"] is! List) throw Exception("Invalid response");
      final List apis = result["apiList"] ?? [];

      gwStatusNotifier.value = DVoteGatewayStatus(
          true, result["health"] ?? 0, apis.cast<String>().toList());
    }).catchError((err) {
      print(err.toString());
      gwStatusNotifier.value = DVoteGatewayStatus(false, 0, <String>[]);
    });
  }, []);
  return gwStatusNotifier;
}

ValueNotifier<VochainStats?> useVochainStats() {
  final VochainStats? stats = null;
  final vochainStats = useState(stats);
  useEffect(() {
    final req = {"method": "getStats", "timestamp": getTimestampForGateway()};
    useGatewayPool().value.sendRequest(req).then((result) {
      if (result["stats"] is! Map) throw Exception("Invalid response");

      final Map<String, dynamic> stats = result["stats"];
      final blockTime = stats["block_time"];
      if (blockTime is! List) throw Exception("Invalid response");

      vochainStats.value = VochainStats(
          blockHeight: stats["block_height"],
          entityCount: stats["entity_count"],
          envelopeCount: stats["envelope_count"],
          processCount: stats["process_count"],
          // transactionCount: stats["transaction_count"],
          validatorCount: stats["validator_count"],
          blockTime: blockTime.cast<int>(),
          blockTimeStamp: stats["block_time_stamp"],
          chainId: stats["chain_id"],
          genesisTimeStamp: stats["genesis_time_stamp"],
          syncing: stats["syncing"]);
    }).catchError((err, s) {
      print(err.toString() + s.toString());
      vochainStats.value =
          VochainStats(blockTime: List<int>.empty(), genesisTimeStamp: "");
    });
  }, []);
  return vochainStats;
}

ValueNotifier<VochainProcess?> useLastProcess() {
  final VochainProcess? process = null;
  final processInfo = useState(process);
  useEffect(() {
    final req = {
      "method": "getProcessInfo",
      "timestamp": getTimestampForGateway(),
      "processId":
          "5270ca038a518c3d94e65c8f6827fb3dbf4d7f081dc65cc18f2a367fd9ca5a81",
    };
    useGatewayPool().value.sendRequest(req).then((result) {
      if (result["process"] is! Map) throw Exception("Invalid response");

      final Map<String, dynamic> process = result["process"];

      processInfo.value = VochainProcess(
        id: process["processId"],
        entityId: process["entityId"],
        metadata: process["metadata"],
        censusOrigin: process["censusOrigin"],
        status: process["status"],
        creationTime: process["creationTime"],
        haveResults: process["haveResults"],
        finalResults: process["finalResults"],
        sourceBlockHeight: process["sourceBlockHeight"],
        sourceNetworkId: process["sourceNetworkId"],
      );
    }).catchError((err, s) {
      print(err.toString() + s.toString());
      processInfo.value = VochainProcess();
    });
  }, []);
  return processInfo;
}
