import 'package:flutter/material.dart';

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path()
      ..moveTo(width / 5, height / 10)
      ..lineTo(width * 4 / 5, height / 10)
      ..lineTo(width * 11 / 12, height * 6 / 10)
      ..lineTo(width / 12, height * 6 / 10)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
