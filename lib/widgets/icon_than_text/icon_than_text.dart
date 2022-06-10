import 'package:flutter/material.dart';
import 'package:shop_delivery_system/widgets/App_Icons/app_icons.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';

class Icon_Than_Text extends StatelessWidget {
  IconData icon;
  Color color;
  String  text;
   Icon_Than_Text({Key? key,required this.icon,required this.text,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     child: Row(
        children: [
           AppIcons(icon: icon,containerSize: 40,iconSize: 24,backgruondcolor: color,iconColor: Colors.white,),
           SizedBox(width: 15,),
           BigText(textbody: text,color: Colors.black54,),
        ],
      )
    );
  }
}
