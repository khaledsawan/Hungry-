import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import '../../Controller/user_profile_controller.dart';
import '../../services/model/update_profile_model.dart';
import '../../widgets/Custom_snackpar/show_custom_snackpar_red.dart';
import '../../widgets/inputtextform/inputtextform.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String userId = '';

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        showCustomSnackParRed('at lest set 1 charters', 'short name');
      } else if (!GetUtils.isEmail(emailController.text.trim())) {
        showCustomSnackParRed('Examble@examble.com', 'not email');
      } else if (!GetUtils.isNum(phoneController.text.trim())) {
        showCustomSnackParRed('only number', 'not number');
      } else {
        userProfileController.updateUserProfile(UpdateProfileModel(
            phone: int.parse(phoneController.text.trim()),
            email: emailController.text.trim(),
            f_name: nameController.text.trim()));
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Row(
            children:  [
              Text(
                'Edit Profile'.tr,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
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
                          SizedBox(
                              width: width - 17,
                              height: height * 0.22,
                              child:
                                  Image.asset('assets/image/userprofile.png')),
                          Positioned(
                            left: 170,
                            right: 40,
                            height: 60,
                            top: 30,
                            child: SizedBox(
                                width: width - 10,
                                height: height * 0.1,
                                child:
                                    Image.asset('assets/image/settings.png')),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Column(
                          children: [
                        InPutTextForm(
                          textEditingController: nameController,
                          color: AppColors.mainColor,
                          hintText: 'name',
                          icon: Icons.person_outline,
                          hintcolor: Colors.grey,
                        ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Column(
                          children: [
                        InPutTextForm(
                          textEditingController: emailController,
                          color: AppColors.mainColor,
                          hintText: 'yourEmail@example.com',
                          icon: Icons.email_outlined,
                          hintcolor: Colors.grey,
                        ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Column(
                          children: [
                        InPutTextForm(
                          textEditingController: phoneController,
                          color: AppColors.mainColor,
                          hintText: 'phone',
                          icon: Icons.phone_iphone_outlined,
                          hintcolor: Colors.grey,
                        ),
                          ],
                        ),
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
                                    color: AppColors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                :const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ));
          },
        ));
  }
}
