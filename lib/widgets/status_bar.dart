import 'package:explorer_flutter_prototype/hooks/gateway.dart';
import 'package:explorer_flutter_prototype/net/gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusBar extends HookWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = useGwStatus();
    final stats = useVochainStats();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            status.value != null
                ? statusWidget(status)
                : Text("Loading gateway status..."),
            stats.value != null ? statsWidget(stats) : Text("Loading stats..."),
          ],
        ),
      )),
    );
  }

  Container statusWidget(ValueNotifier<DVoteGatewayStatus?> status) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gateway health: " + status.value!.health.toString()),
          Text("Gateway status: " + (status.value!.isUp ? "up" : "down")),
          Text("Supported apis: " + status.value!.supportedApis.toString()),
        ],
      ),
    );
  }

  Container statsWidget(ValueNotifier<VochainStats?> stats) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Block height: " + stats.value!.blockHeight.toString()),
          Text("Entity count: " + stats.value!.entityCount.toString()),
          Text("Envelope count: " + stats.value!.envelopeCount.toString()),
          Text("Process count: " + stats.value!.processCount.toString()),
          Text("Validator count: " + stats.value!.validatorCount.toString()),
          Text("Block time: " + stats.value!.blockTime.join(", ")),
          Text("Block timestamp: " + stats.value!.blockTimeStamp.toString()),
          Text("Chain ID: " + stats.value!.chainId),
          Text("Genesis timestamp: " + stats.value!.genesisTimeStamp),
          Text("Syncing: " + stats.value!.syncing.toString()),
        ],
      ),
    );
  }
}
