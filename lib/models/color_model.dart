import 'package:flutter/material.dart';

class ColorModel {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;

  ColorModel({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
}
