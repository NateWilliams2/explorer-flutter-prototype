import 'package:explorer_flutter_prototype/widgets/status_bar.dart';
import 'package:flutter/material.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: StatusBar()),
    );
  }
}
