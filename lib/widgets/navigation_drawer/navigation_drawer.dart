import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:explorer_flutter_prototype/router/router_names.dart';
import 'package:flutter/material.dart';

import 'drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  final NavigationService navigator;
  const NavigationDrawer(this.navigator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerItem('Home', HomeRoute, navigator, Icons.home),
          DrawerItem(
              'Blocks', BlocksRoute, navigator, Icons.blur_linear_outlined),
          DrawerItem('Transactions', TransactionsRoute, navigator,
              Icons.transform_outlined),
          DrawerItem('Entities', EntitiesRoute, navigator, Icons.group),
          DrawerItem('Processes', ProcessesRoute, navigator,
              Icons.how_to_vote_outlined),
          DrawerItem('Validators', ValidatorsRoute, navigator, Icons.check_box),
          DrawerItem('Stats', StatsRoute, navigator, Icons.graphic_eq),
        ],
      ),
    );
  }
}
