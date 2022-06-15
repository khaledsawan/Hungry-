import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import '../../Controller/auth_controller.dart';
import '../../Controller/user_profile_controller.dart';
import '../../services/model/update_profile_model.dart';
import '../../widgets/Custom_snackpar/show_custom_snackpar.dart';
import '../../widgets/inputtextform/inputtextform.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isAuth = false;
  String userId = '';

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    print('update');
    _isAuth = Get.find<AuthController>().isAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    UserProfileController userProfileController = Get.find();
    if (userProfileController.userProfileModel.isNull) {
      userProfileController.getProfileInfo().then((status) {
        if (status.isSuccessful!) {
          // Get.offAllNamed(AppRoutes.InitHome);
        } else {}
      });
    }

    //print(userid+'///////////////////');

    update() {
      // if (nameController.text.trim().isNotEmpty) {
      //   if (!GetUtils.isEmail(emailController.text.trim())) {
      //     if (!GetUtils.isNum(phoneController.text.trim())) {
            Get.find<UserProfileController>().updateUserProfile(
                UpdateProfileModel(
                    id: int.parse(userId),
                    email: emailController.text.trim(),
                    phone: int.parse(phoneController.text.trim()),
                    f_name: nameController.text.trim())).then((value) => ShowCustomSnackpar(value.massage.toString(),''));
      //     } else {
      //       ShowCustomSnackpar('only number', 'not number');
      //     }
      //   } else {
      //     ShowCustomSnackpar('Examble@examble.com', 'not email');
      //   }
      // } else {
      //   ShowCustomSnackpar('at lest set 1 charters', 'short name');
      // }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(
              child: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 24),
          )),
        ),
        body: GetBuilder<UserProfileController>(
          builder: (userController) {
            return !userController.isLoaded
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Center(
                          child: Container(
                              width: width - 17,
                              height: height * 0.22,
                              child:
                                  Image.asset('assets/image/editprofile.png')),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                            child: Column(
                          children: [
                            InPutTextForm(
                              textEditingController: nameController,
                              color: AppColors.mainColor,
                              hintText: userController.userProfileModel!.fName
                                  .toString(),
                              icon: Icons.person_outline,
                              hintcolor: Colors.grey,
                            ),
                          ],
                        )),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                            child: Column(
                          children: [
                            InPutTextForm(
                              textEditingController: emailController,
                              color: AppColors.mainColor,
                              hintText: userController.userProfileModel!.email
                                  .toString(),
                              icon: Icons.email_outlined,
                              hintcolor: Colors.grey,
                            ),
                          ],
                        )),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                            child: Column(
                          children: [
                            InPutTextForm(
                              textEditingController: phoneController,
                              color: AppColors.mainColor,
                              hintText: userController.userProfileModel!.phone
                                  .toString(),
                              icon: Icons.phone_iphone_outlined,
                              hintcolor: Colors.grey,
                            ),
                          ],
                        )),
                        SizedBox(
                          height: height * 0.08,
                        ),
                        GestureDetector(
                          onTap: () {
                            update();
                          },
                          child: Container(
                            width: width * 0.5,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400]!,
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 4),
                                      blurStyle: BlurStyle.normal),
                                ]),
                            child: const Center(
                              child: Text(
                                'Update profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ));
          },
        ));
  }
}
