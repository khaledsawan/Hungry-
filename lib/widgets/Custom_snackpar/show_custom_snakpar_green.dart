import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackParGreen(String massage, String title,
    {Color backGroundColor = Colors.green, Color textColor = Colors.white}) {
  Get.snackbar(title, massage,
      backgroundColor: backGroundColor, colorText: textColor);
}
