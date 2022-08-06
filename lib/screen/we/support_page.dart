import 'package:flutter/material.dart';
import 'package:shop_delivery_system/widgets/button/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  _makingPhoneCall() async {
    var url = Uri.parse("tel:(+963) 967184204");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: const Text(
              'Support        ',
              style: TextStyle(fontSize: 24),
            )),
        body: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          padding: const EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: SizedBox(
                      width: width - 15,
                      height: height * 0.19,
                      child: Image.asset('assets/image/Support_blue4png.png')),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                const Text(
                  'Need Some Helps?',
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      color: AppColors.titleColor),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Text(
                  'Get lost? Don\'t know how to use?',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: AppColors.textColor),
                ),
                const Text(
                  'Feel free to get in touch with us',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: AppColors.textColor),
                ),
                SizedBox(
                  height: height * 0.075,
                ),
                GestureDetector(
                  onTap: (){
                    _makingPhoneCall();
                  },
                  child: Container(
                    width: width * 0.8,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
//support
