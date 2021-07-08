import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService() {
    print("New navigation");
  }

  Future<dynamic>? navigateTo(String routeName) {
    routeName = Uri(path: routeName).toString();
    print(routeName);
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  goBack() {
    navigatorKey.currentState?.pop();
  }
}

NavigationService useNavigator() {
  return useMemoized<NavigationService>(() => NavigationService());
}
