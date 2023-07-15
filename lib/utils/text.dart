import 'package:chat_app/utils/global_colors.dart';
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

  static splashHead() {
    return GoogleFonts.truculenta(
      color: AppColors.appColor,
      fontWeight: FontWeight.w700,
      letterSpacing: 16,
      fontSize: 30,
    );
  }
}
