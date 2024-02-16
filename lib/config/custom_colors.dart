import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(237, 240, 248, .1),
  100: const Color.fromRGBO(237, 240, 248, .2),
  200: const Color.fromRGBO(140, 161, 225, .3),
  300: const Color.fromRGBO(139, 195, 74, .4),
  400: const Color.fromRGBO(139, 195, 74, .5),
  500: const Color.fromRGBO(139, 195, 74, .6),
  600: const Color.fromRGBO(139, 195, 74, .7),
  700: const Color.fromRGBO(139, 195, 74, .8),
  800: const Color.fromRGBO(139, 195, 74, .9),
  900: const Color.fromRGBO(139, 195, 74, .1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.red.shade700;

  static MaterialColor customSwatchColor =
      MaterialColor(0xFF4CAF50, _swatchOpacity);

  static MaterialColor customShapeColor =
      MaterialColor(0xffeff2f9, _swatchOpacity);
}
