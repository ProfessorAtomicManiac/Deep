import 'package:flutter/material.dart';

mixin Constants {

  static const double LABEL_LARGE_FONT_SIZE = 20;
  static const double DEFAULT_ICON_SIZE = 25;

  // 11.5% baseline lower to align with text
  // use with paddings
  static EdgeInsets alignIconToText({double iconSize = DEFAULT_ICON_SIZE}) {
    return EdgeInsets.only(top: .115 * iconSize);
  }

  static BorderRadius curveBorderToIcon({double iconSize = DEFAULT_ICON_SIZE}) {
    return BorderRadius.all(Radius.circular(iconSize));
  }
}