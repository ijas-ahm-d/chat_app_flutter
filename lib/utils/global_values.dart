import 'package:flutter/material.dart';

class AppSizes {
  // Heights

  static const kHeight20 = SizedBox(height: 20);
  static const kHeight30 = SizedBox(height: 30);
  static const kHeight40 = SizedBox(height: 40);
  static const kHeight50 = SizedBox(height: 50);
  static const kHeight10 = SizedBox(height: 10);
  static const kHeight5 = SizedBox(height: 5);

// Widths

  static const kWidth5 = SizedBox(width: 5);
  static const kWidth10 = SizedBox(width: 10);
  static const kWidth20 = SizedBox(width: 20);
  static const kWidth25 = SizedBox(width: 25);
  static const kWidth30 = SizedBox(width: 30);
  static const kWidth40 = SizedBox(width: 40);
  static const kWidth50 = SizedBox(width: 50);
}

class SpaceWH extends StatelessWidget {
  final double? width;
  final double? height;
  const SpaceWH({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }
}
