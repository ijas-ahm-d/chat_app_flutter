import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static onText(double size, FontWeight fwght, Color clr) {
    return GoogleFonts.montserrat(
      letterSpacing: 0.5,
      fontSize: size,
      fontWeight: fwght,
      color: clr,
    );
  }
}
