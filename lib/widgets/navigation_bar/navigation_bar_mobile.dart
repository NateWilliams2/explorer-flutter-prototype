import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:flutter/material.dart';

class NavigationBarMobile extends StatelessWidget {
  final NavigationService navigator;
  const NavigationBarMobile(this.navigator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.maybeOf(context)?.openDrawer(),
          ),
        ],
      ),
    );
  }
}
