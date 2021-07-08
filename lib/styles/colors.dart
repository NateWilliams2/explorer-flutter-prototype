import 'package:flutter/material.dart';

const _primaryColorCode = 0xFF212529;
final backgroundTextColor = Colors.white.withOpacity(0.5);
final primaryTextColor = Colors.white.withOpacity(0.5);

final Map<int, Color> _primarySwatchColorCodes = {
  50: Color(_primaryColorCode).withOpacity(0.1),
  100: Color(_primaryColorCode).withOpacity(0.2),
  200: Color(_primaryColorCode).withOpacity(0.3),
  300: Color(_primaryColorCode).withOpacity(0.4),
  400: Color(_primaryColorCode).withOpacity(0.5),
  500: Color(_primaryColorCode).withOpacity(0.6),
  600: Color(_primaryColorCode).withOpacity(0.7),
  700: Color(_primaryColorCode).withOpacity(0.9),
  800: Color(_primaryColorCode).withOpacity(0.9),
  900: Color(_primaryColorCode).withOpacity(1),
};

final primarySwatch =
    MaterialColor(_primaryColorCode, _primarySwatchColorCodes);
