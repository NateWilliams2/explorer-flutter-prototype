import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:explorer_flutter_prototype/router/router.dart';
import 'package:explorer_flutter_prototype/router/router_names.dart';
import 'package:explorer_flutter_prototype/styles/theme.dart';
import 'package:explorer_flutter_prototype/views/layout_template/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = useNavigator();
    return MaterialApp(
      title: 'Explorer Flutter Prototype',
      theme: mainTheme,
      builder: (context, child) => LayoutTemplate(navigator, child: child),
      navigatorKey: navigator.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
