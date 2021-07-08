import 'package:explorer_flutter_prototype/hooks/gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusBar extends HookWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = useGwStatus();
    return Container(
      child: Column(
        children: [
          Text("Gateway health: " + status.value.health.toString()),
          Text("Gateway status: " + (status.value.isUp ? "up" : "down")),
          Text("Supported apis: " + status.value.supportedApis.toString()),
        ],
      ),
    );
  }
}
