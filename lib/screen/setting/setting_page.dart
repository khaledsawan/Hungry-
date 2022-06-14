import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';

import '../../routes/AppRoutes.dart';
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon_Than_Text(
                            color: AppColors.mainColor,
                            icon: Icons.language_outlined,
                            text: 'language',
                          ),
                          GestureDetector(
                            onTap: () {

                              ChangeLanguageAlertDialog(context);
                            },
                            child: const SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.arrow_right_outlined,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                       Divider(color: AppColors.textColor,),
                      SizedBox(
                        height: height * 0.01,

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon_Than_Text(
                            color: AppColors.mainColor,
                            icon: Icons.person_outline,
                            text: 'edit profile',
                          ),
                          GestureDetector(
                            onTap: () {
                              print('tapped');
                              Get.toNamed(AppRoutes.EditProfile);
                            },
                            child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.arrow_right_outlined,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                       Divider(color: AppColors.textColor,),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon_Than_Text(
                            color: AppColors.mainColor,
                            icon: Icons.dark_mode_outlined,
                            text: 'them mode',
                          ),
                          GestureDetector(
                            onTap: () {
                              print('tapped');
                             // Get.theme.c;
                            },
                            child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.arrow_right_outlined,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                       Divider(color: AppColors.textColor,),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon_Than_Text(
                            color: AppColors.mainColor,
                            icon: Icons.support_agent_outlined,
                            text: 'support',
                          ),
                          GestureDetector(
                            onTap: () {
                              print('tapped');
                             Get.toNamed(AppRoutes.Support);
                           },
                            child: const SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.arrow_right_outlined,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                       Divider(color: AppColors.textColor,),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon_Than_Text(
                            color: AppColors.mainColor,
                            icon: Icons.group_outlined,
                            text: 'about us',
                          ),
                          GestureDetector(
                            onTap: () {
                              print('tapped');
                             Get.toNamed(AppRoutes.Aboutpage);
                            },
                            child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.arrow_right_outlined,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                       Divider(color: AppColors.textColor,),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
