import 'package:explorer_flutter_prototype/widgets/status_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: StatusBar());
  }
}
