import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';

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
      content: Container(
          width: double.maxFinite,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(locale[index]['name']),
                    onTap: () {
// print(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'hello'.tr,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'message'.tr,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  ChangeLanguageAlertDialog(context);
                },
                child: Text('changelang'.tr)),
          ],
        ));
  }
}
