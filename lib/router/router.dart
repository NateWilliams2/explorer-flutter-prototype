import 'package:explorer_flutter_prototype/router/router_names.dart';
import 'package:explorer_flutter_prototype/views/blocks_view.dart';
import 'package:explorer_flutter_prototype/views/entities_view.dart';
import 'package:explorer_flutter_prototype/views/home_view.dart';
import 'package:explorer_flutter_prototype/views/processes_view.dart';
import 'package:explorer_flutter_prototype/views/stats_view.dart';
import 'package:explorer_flutter_prototype/views/transactions_view.dart';
import 'package:explorer_flutter_prototype/views/validators_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomeView());
    case BlocksRoute:
      return _getPageRoute(BlocksView());
    case TransactionsRoute:
      return _getPageRoute(TransactionsView());
    case EntitiesRoute:
      return _getPageRoute(EntitiesView());
    case ProcessesRoute:
      return _getPageRoute(ProcessesView());
    case ValidatorsRoute:
      return _getPageRoute(ValidatorsView());
    case StatsRoute:
      return _getPageRoute(StatsView());
    default:
      return _getPageRoute(HomeView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute(this.child)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
