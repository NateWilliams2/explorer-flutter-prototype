import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:explorer_flutter_prototype/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'navbar_button.dart';
import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends HookWidget {
  final NavigationService navigator;
  const NavigationBarTabletDesktop(this.navigator, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavButton("Home", HomeRoute, navigator),
              NavButton("Blocks", BlocksRoute, navigator),
              NavButton("Transactions", TransactionsRoute, navigator),
              NavButton("Entities", EntitiesRoute, navigator),
              NavButton("Processes", ProcessesRoute, navigator),
              NavButton("Validators", ValidatorsRoute, navigator),
              NavButton("Stats", StatsRoute, navigator),
            ],
          )
        ],
      ),
    );
  }
}
