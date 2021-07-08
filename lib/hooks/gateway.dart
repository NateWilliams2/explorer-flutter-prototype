import 'package:explorer_flutter_prototype/net/gateway.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<DVoteGateway> useGatewayPool() {
  // Initialize value notifier with empty gateway pool
  ValueNotifier<DVoteGateway> dVoteGatewayNotifier =
      ValueNotifier(DVoteGateway("https://gw1.vocdoni.net/dvote"));
  return dVoteGatewayNotifier;
}

ValueNotifier<DVoteGatewayStatus> useGwStatus() {
  final gwStatusNotifier = useState(DVoteGatewayStatus(false, 0, []));
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
