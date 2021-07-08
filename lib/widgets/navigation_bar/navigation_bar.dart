import 'package:explorer_flutter_prototype/hooks/navigation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'navigation_bar_mobile.dart';
import 'navigation_bar_tablet_desktop.dart';

class NavigationBar extends StatelessWidget {
  final NavigationService navigator;
  const NavigationBar(this.navigator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(navigator),
      tablet: NavigationBarTabletDesktop(navigator),
    );
  }
}
