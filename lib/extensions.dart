import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color get contrastingTextColor {
    return ThemeData.estimateBrightnessForColor(this) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}
