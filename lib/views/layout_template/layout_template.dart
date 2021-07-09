import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:explorer_flutter_prototype/widgets/navigation_bar/navigation_bar.dart';
import 'package:explorer_flutter_prototype/widgets/navigation_drawer/navigation_drawer.dart';
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
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Scaffold(
            drawer:
                sizingInformation.deviceScreenType == DeviceScreenType.mobile
                    ? NavigationDrawer(navigator) // Mobile navigation drawer
                    : null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NavigationBar(navigator),
                  child != null
                      ? Expanded(
                          child: child!,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
