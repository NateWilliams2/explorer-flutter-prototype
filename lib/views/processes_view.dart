import 'package:explorer_flutter_prototype/hooks/gateway.dart';
import 'package:explorer_flutter_prototype/net/gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProcessesView extends HookWidget {
  const ProcessesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final process = useLastProcess();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            process.value != null
                ? processWidget(process)
                : Text("Loading process..."),
          ],
        ),
      )),
    );
  }
}

Container processWidget(ValueNotifier<VochainProcess?> process) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Process ID: " + process.value!.id),
        Text("Entity ID: " + process.value!.entityId),
        Text("Metadata origin: " + process.value!.metadata),
        Text("Census origin: " + process.value!.censusOrigin.toString()),
        Text("Status: " + process.value!.status.toString()),
        Text("Creation time: " + process.value!.creationTime),
        Text("Has results: " + process.value!.haveResults.toString()),
        Text("Final results: " + process.value!.finalResults.toString()),
        Text("Source block height: " +
            process.value!.sourceBlockHeight.toString()),
        Text("Source network id: " + process.value!.sourceNetworkId),
      ],
    ),
  );
}
