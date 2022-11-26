import 'package:flutter/cupertino.dart';
import '../../utils/colors.dart';

class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double containerSize;
  final double iconSize;
  final Color backGroundColor;
  const AppIcons(
      {Key? key,
      required this.icon,
      this.iconColor = AppColors.black,
      this.containerSize = 40,
      this.iconSize = 18,
      this.backGroundColor = const Color(0xFFf7f6ff), })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(containerSize / 2),
          color: backGroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
