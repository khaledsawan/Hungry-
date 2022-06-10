import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  late Callback? onPressed;
  late String buttonText;
  late double? width;
  late double? height;
  late double? fontSize;
  late double radius;
  late IconData? icon;
  late EdgeInsets? margin;
  late EdgeInsets? padding;
  late bool transparent;

  CustomButton(
      {Key? key,
      required this.buttonText,
      this.onPressed,
      this.width,
      this.height=50,
      this.fontSize,
      this.icon,
      this.margin,
      this.padding,
      this.transparent = false,
      this.radius = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Theme.of(context).primaryColor,
        minimumSize: Size(
            width == null ? width! : MediaQuery.of(context).size.width,
            height == null ? height! : MediaQuery.of(context).size.height),
        padding: padding ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ));
    return Center(
      child: SizedBox(
        width: width == null ? width! : MediaQuery.of(context).size.width,
        height: height ?? 50,
        child: TextButton(
          style: _flatButton,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor))
                  : const SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: fontSize ?? 16,
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
