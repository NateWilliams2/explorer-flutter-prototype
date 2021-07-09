import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final NavigationService navigator;
  final IconData icon;
  const DrawerItem(this.title, this.navigationPath, this.navigator, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextButton(
        onPressed: () =>
            navigator.navigatorKey.currentState?.pushNamed(navigationPath),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).accentIconTheme.color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(title, style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
