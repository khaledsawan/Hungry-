import 'package:flutter/material.dart';
import 'package:shop_delivery_system/Services/model/user_signup_model.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import 'package:shop_delivery_system/widgets/Custom_snackpar/show_custom_snackpar_red.dart';
import 'package:shop_delivery_system/widgets/inputtextform/inputtextform.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import 'package:get/get.dart';
import '../../Controller/auth_controller.dart';
import 'sign_in_page.dart';

class SignUpPage extends GetView<AuthController> {
  SignUpPage({Key? key}) : super(key: key);
  List<String> iconList = [
    "g.png",
    "f.png",
    "t.png",
  ];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  void _registeration(AuthController authController) async{
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    if (name.isEmpty) {
      showCustomSnackParRed('enter name', 'name is empty');
    } else if (email.isEmpty) {
      showCustomSnackParRed('enter email', 'email is empty');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackParRed('not email', 'not email');
    } else if (!GetUtils.isNum(phone)) {
      showCustomSnackParRed('you need to enter number', 'not number');
    } else if (password.isEmpty) {
      showCustomSnackParRed('enter password', 'password is emoty');
    } else if (password.length < 6) {
      showCustomSnackParRed(
          'short password must more than 6 characters', 'short password');
    } else {
      UserSignUpModel signUpModel =
      UserSignUpModel(name, phone, email, password);

      authController.registeration(signUpModel).then((status) {
        if (status.isSuccessful!) {
          Get.offNamed(AppRoutes.InitHome);
        } else {
          showCustomSnackParRed(
              status.massage.toString() +
                  ' password or phone number not correct',
              'error');
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        backgroundColor: AppColors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return !controller.isloading
              ? SingleChildScrollView(
                  child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                      child: SizedBox(
                          width: width * 0.7,
                          height: height * 0.2,
                          child: Image.asset('assets/image/logo part 1.png'))),
                  InPutTextForm(
                      icon: Icons.person,
                      hintcolor: AppColors.textColor,
                      hintText: 'name',
                      color: AppColors.mainColor,
                      textEditingController: nameController),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  InPutTextForm(
                      icon: Icons.email,
                      hintcolor: AppColors.textColor,
                      hintText: 'email',
                      color: AppColors.mainColor,
                      textEditingController: emailController),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  InPutTextForm(
                      icon: Icons.phone,
                      hintcolor: AppColors.textColor,
                      hintText: 'phone',
                      color: AppColors.mainColor,
                      textEditingController: phoneController),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  InPutTextForm(
                    icon: Icons.password,
                    hintcolor: AppColors.textColor,
                    hintText: 'password',
                    color: AppColors.mainColor,
                    textEditingController: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      _registeration(controller);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: height * 0.07,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: AppColors.white, fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: GestureDetector(
                        child: GestureDetector(
                      onTap: () {
                        Get.to(() => const SignInPage());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(
                            textbody: 'have an user account ',
                            color: AppColors.textColor,
                            size: 18,
                          ),
                          BigText(
                            textbody: 'already?',
                            color:AppColors.black,
                            size: 18,
                          ),
                        ],
                      ),
                    )),
                  ),
                  SizedBox(
                    height: height * 0.080,
                  ),
                  SmailText(
                    textbody: 'Sign up using one of the following method',
                    size: 18,
                    color: AppColors.textColor,
                  ),
                  Wrap(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    "assets/image/" + iconList[index]),
                              ),
                            )),
                  ),
                ]))
              :const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                    backgroundColor: AppColors.white,
                  ),
                );
        }));
  }
}


