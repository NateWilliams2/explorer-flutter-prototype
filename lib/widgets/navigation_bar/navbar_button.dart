import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String title;
  final String navigationPath;
  final NavigationService navigator;

  NavButton(this.title, this.navigationPath, this.navigator);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
          onPressed: () =>
              navigator.navigatorKey.currentState?.pushNamed(navigationPath),
          child: Text(title),
          style: Theme.of(context).textButtonTheme.style),
    );
  }
}
