import 'dart:ui';

import 'package:flutter/material.dart';

class CommonColors {
  static const primaryColor =  Color(0xFFC90202);
  static const primaryTextColor =  Color(0xFF323142);
  static const searchTextColor =  Color(0xFF8C8C8C);
}

class AppStyle {
  static var colors = [
    [
      const Color(0xFFD1F4F4),
      const Color(0xFF95D4D4),
      const Color(0xFF85E1E1),
      const Color(0xFF78DCB0),
      const Color(0xFF30C8C7),
      const Color(0xFF22C9C8),
      const Color(0xFF1EC8C8),
    ],
    [
      const Color(0xFFFAFEFE),
      const Color(0xFFF8F9FC),
      const Color(0xFFF5F6FA),
      const Color(0xFFD4E2E2),
      const Color(0xFFD4DDE3),
      const Color(0xFF9FA4AE),
      const Color(0xFF8D9EA4),
      const Color(0xFF4B4D5A),
      const Color(0xFFe0dcdc)
    ],
    [
      const Color(0xFF2f4862),
      const Color(0xFF15416e),
      const Color(0xFF18ba60),
      const Color(0xFFe7505a),
      const Color(0xFF217EBD),
      const Color(0xFFffc439),
    ],
  ];

  static const borderRadiusCicular = BorderRadius.all(Radius.circular(3.0));
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      // ignore: prefer_interpolation_to_compose_strings
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
