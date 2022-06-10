import 'package:flutter/material.dart';
import 'package:shop_delivery_system/utils/colors.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}
class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : SingleChildScrollView(
            child: new Column(
        children: <Widget>[
            new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style: TextStyle(color: AppColors.textColor),),
            new InkWell(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    flag ? "show more" : "show less",
                    style: new TextStyle(color: AppColors.mainColor),
                  ),
                  Icon(flag?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,),
                ],
              ),
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            ),
        ],
      ),
          ),
    );
  }
}
