import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import '../../Controller/user_profile_controller.dart';
import '../../services/model/update_profile_model.dart';
import '../../widgets/inputtextform/inputtextform.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String username =
        Get.find<UserProfileController>().userProfileModel!.fName.toString();
    String useremail =
        Get.find<UserProfileController>().userProfileModel!.email.toString();
    String userphone =
        Get.find<UserProfileController>().userProfileModel!.phone.toString();
    String userid =
        Get.find<UserProfileController>().userProfileModel!.id.toString();

    nameController.text = username;
    emailController.text = useremail;
    phoneController.text = userphone;

    update() {
      if (nameController.text.isNotEmpty) {
        if (emailController.text.isNotEmpty) {
          if (phoneController.text.isNotEmpty) {
            Get.find<UserProfileController>().updateUserProfile(
                UpdateProfileModel(
                    id: int.parse(userid!),
                    email: emailController.text,
                    phone: int.parse(phoneController.text),
                    f_name: nameController.text));
          } else {}
        } else {
        }
      } else {

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Container(
                  width: width - 17,
                  height: height * 0.22,
                  child: Image.asset('assets/image/editprofile.png')),
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
                  hintText: 'email',
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
              onTap: () {},
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
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
