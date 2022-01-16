import 'package:flutter/material.dart';

Color getColor(String category) {
  switch (category) {
    case 'Food':
      return Colors.green[700]!;
    case 'Entertainment':
      return Colors.purple[700]!;
    default:
      return Colors.orange[700]!;
  }
}
