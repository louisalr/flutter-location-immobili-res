import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/share/location_style.dart';

class LocationTextStyle{
  static final baseTextStyle = GoogleFonts.getFont('Raleway')
                                    .copyWith(color: LocationStyle.colorPurple);

  static final regularTextStyle = baseTextStyle.copyWith(
    fontSize: 13
  );

  static final regularWhiteTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 13
  );

  static final priceTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final priceGreyTextStyle = priceTextStyle.copyWith(
    color: Colors.grey,
  );

  static final regularGreyTextStyle = baseTextStyle.copyWith(
    color: Colors.grey,
    fontSize: 13,
  );

  static final boldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold
  );

  static final subTitleBoldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}