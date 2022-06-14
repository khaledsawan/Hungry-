import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';

import '../../widgets/icon_than_text/icon_than_text.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'Arabic', 'locale': Locale('ar', 'SY')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

//ChangeLanguageAlertDialog Start
  ChangeLanguageAlertDialog(BuildContext context) {
// set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );
// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Choose Your Language'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(locale[index]['name']),
                    onTap: () {
                      updateLanguage(locale[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locale.length)),
    );
// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//ChangeLanguageAlertDialog End
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Setting'.tr,
            style: TextStyle(fontSize: 24),
          )),
          backgroundColor: AppColors.mainColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
                width: width - 17,
                height: height * 0.22,
                child: Image.asset('assets/image/settings.png')),

            SizedBox(
              height: height * 0.05,
            ),
           Container(
             margin:const EdgeInsets.only(left: 40,right: 20),
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Icon_Than_Text(
                        color: AppColors.mainColor,
                        icon: Icons.language_outlined,
                        text: 'language',
                      ),
                   SizedBox(
                     height: height * 0.05,
                   ),
                   Icon_Than_Text(
                     color: AppColors.mainColor,
                     icon: Icons.person,
                     text: 'Edit profile',
                   ),
                   SizedBox(
                     height: height * 0.05,
                   ),
                   Icon_Than_Text(
                     color: AppColors.mainColor,
                     icon: Icons.dark_mode_outlined,
                     text: 'change them ',
                   ),
                   SizedBox(
                     height: height * 0.05,
                   ),
                   Icon_Than_Text(
                     color: AppColors.mainColor,
                     icon: Icons.support_outlined,
                     text: 'Support',
                   ),
                   SizedBox(
                     height: height * 0.05,
                   ),
                   Icon_Than_Text(
                     color: AppColors.mainColor,
                     icon: Icons.group_outlined,
                     text: 'about Us',
                   ),
                   SizedBox(
                     height: height * 0.05,
                   ),

                 ],
               ),
             ),
           ),

          ],
        ));
  }
}
