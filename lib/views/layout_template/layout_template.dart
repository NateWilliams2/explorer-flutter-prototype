import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:explorer_flutter_prototype/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends HookWidget {
  final Widget? child;
  final NavigationService navigator;
  const LayoutTemplate(this.navigator, {this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? null // Mobile navigation drawer
            : null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NavigationBar(navigator),
              child != null
                  ? Expanded(
                      child: child!,
                      // child: Navigator(
                      //   key: navigator.navigatorKey,
                      //   onGenerateRoute: generateRoute,
                      //   initialRoute: HomeRoute,
                      // ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
