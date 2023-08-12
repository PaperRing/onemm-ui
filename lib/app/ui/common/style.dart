import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnemmColor {
  static const ONE_MM_COLOR = Color.fromRGBO(255, 201, 83, 1);
  static const ONE_MM_COLOR_7 = Color.fromRGBO(255, 201, 83, 0.7);
  static const ONE_MM_COLOR_2 = Color.fromRGBO(255, 201, 83, 0.2);

  static const LIGHT_YELLOW = Color.fromRGBO(255, 201, 83, 0.4);
  static const GRAY_COLOR_10 = Color.fromRGBO(191, 188, 172, 1);
  static const GRAY_COLOR_8 = Color.fromRGBO(191, 188, 172, 0.8);
  static const GRAY_COLOR_3 = Color.fromRGBO(191, 188, 172, 0.3);
  static const GRAY_COLOR_2 = Color.fromRGBO(191, 188, 172, 0.2);

  static const GRAY_COLOR_1 = Color.fromRGBO(191, 188, 172, 0.1);

  static const DARK_GRAY_COLOR = Color.fromRGBO(119, 116, 97, 1);
  static const LIGHT_GRAY_COLOR = Color.fromRGBO(191, 188, 172, 0.2);
  static const BACKGROUND_COLOR = Color.fromRGBO(249, 249, 249, 6);
  static const BLUE_TEXT_COLOR = Color.fromRGBO(0, 104, 195, 1);
  static const COMMON_TEXT_COLOR = Color.fromRGBO(85, 85, 85, 1);

  static const test = Color.fromRGBO(84, 68, 34, 1);
// static const test = Color.fromRGBO(51, 41, 20, 1);
}

class CustomStyle {
  static final PADDING = EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w);
  static final NO_APPBAR_PADDING = EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w, top: 40.w);
  static final TEXT_BUTTON_NO_PADDING = TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap, padding: EdgeInsets.zero);
  static final CONTAINER_CIRCLE = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20));
  static final TextStyle TAB_TEXT_COLOR = TextStyle(color: Colors.black87, fontSize: FontSize.BASIC_TEXT.sp);
  static final TextStyle TEXT_SIZE_MIDDLE = TextStyle(fontSize: 13.sp);
}

class CommonIcon {
  static final BACK_BUTTON = 'assets/icons/back.png';
}

class FontSize {
  static const TITLE_20 = 20;
  static const TITLE_18 = 18;

  static const TITLE_MIDDLE_17 = 17;
  static const TITLE_MIDDLE_16 = 16;

  // static const MIDDLE_TEXT_15 = 15;
  static const MIDDLE_TEXT_13 = 13;

  static const MIDDLE_TEXT_11 = 11;
  static const BASIC_TEXT = 14;
  static const BASIC_SMALL_TEXT = 12;

  static const SMALL_TEXT_10 = 10;
}
