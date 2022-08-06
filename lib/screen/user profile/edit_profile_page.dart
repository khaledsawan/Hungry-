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
    super.initState();
    print('init ');
    nameController.text =
        Get.find<UserProfileController>().userProfileModel!.fName.toString();
    emailController.text =
        Get.find<UserProfileController>().userProfileModel!.email.toString();
    phoneController.text =
        Get.find<UserProfileController>().userProfileModel!.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    UserProfileController userProfileController = Get.find();
    if (userProfileController.userProfileModel.isNull) {
      userProfileController.getProfileInfo().then((status) {
        if (status.isSuccessful!) {}
      });
    }

    update(UserProfileController userProfileController) {
      if (nameController.text.trim().isEmpty) {
        ShowCustomSnackpar('at lest set 1 charters', 'short name');
      } else if (!GetUtils.isEmail(emailController.text.trim())) {
        ShowCustomSnackpar('Examble@examble.com', 'not email');
      } else if (!GetUtils.isNum(phoneController.text.trim())) {
        ShowCustomSnackpar('only number', 'not number');
      } else {
        print(phoneController.text.trim());
        print(emailController.text.trim());
        print(nameController.text.trim());

        userProfileController.updateUserProfile(UpdateProfileModel(
            phone: int.parse(phoneController.text.trim()),
            id: int.parse(
                userProfileController.userProfileModel!.id.toString()),
            email: emailController.text.trim(),
            f_name: nameController.text.trim()));
      }
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
                        Stack(children: [
                          Container(
                              width: width - 17,
                              height: height * 0.22,
                              child:
                                  Image.asset('assets/image/userprofile.png')),
                          Positioned(
                            left: 170,
                            right: 40,
                            height: 60,
                            top: 30,
                            child: Container(
                                width: width - 10,
                                height: height * 0.1,
                                child: Image.asset('assets/image/settings.png')),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                            child: Column(
                          children: [
                            InPutTextForm(
                              textEditingController: nameController,
                              color: AppColors.mainColor,
                              hintText: 'name',
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
                              hintText: 'yourEmail@example.com',
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
                              hintText: 'phone',
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
                            update(userController);
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
