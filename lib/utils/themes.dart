
  import 'package:flutter/material.dart';
import 'package:shop_delivery_system/utils/colors.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
  backgroundColor: Colors.white,
  primaryColor: AppColors.mainColor,
  buttonColor: Colors.blue,
  );
  static final dark = ThemeData.dark().copyWith(
  backgroundColor: Colors.black,
    primaryColor: Colors.purple,

    buttonColor: Colors.red,
  );
  }
