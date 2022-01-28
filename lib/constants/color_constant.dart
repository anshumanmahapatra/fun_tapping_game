import 'package:flutter/material.dart';
import '../models/color_model.dart';

class ColorConstant {
  final List<ColorModel> getColorConstants = [
    ColorModel(
        text: "Red",
        textColor: Color(0xFFCC0000),
        backgroundColor: Color(0xFFFF9999),
        borderColor: Color(0xFFCC0000)),
    ColorModel(
        text: "Green",
        textColor: Color(0xFF006600),
        backgroundColor: Color(0xFF99CC99),
        borderColor: Color(0xFF006600)),
    ColorModel(
        text: "Blue",
        textColor: Color(0xFF0066CC),
        backgroundColor: Color(0xFF99CCFF),
        borderColor: Color(0xFF0066CC)),
    ColorModel(
        text: "Yellow",
        textColor: Color(0xFFCCCC00),
        backgroundColor: Color(0xFFFFFF99),
        borderColor: Color(0xFFCCCC00))
  ];

  final Color kPrimary = Color(0xFF035AA6);
  final Color kSecondary = Color(0xFFFFCB47);
  final Color kTertiary = Color(0xFFEE4266);
  final Color kQuarternary = Color(0xFFF7EDF0);
}
