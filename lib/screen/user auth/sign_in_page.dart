import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/user%20auth/sign_up_page.dart';
import '../../Controller/auth_controller.dart';
import '../../Services/model/user_signin_model.dart';
import '../../utils/colors.dart';
import '../../widgets/Custom_snackpar/show_custom_snackpar_red.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _loginMethod(AuthController authController) {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackParRed('enter phone number ', 'empty field');
    } else if (!phone.isNum) {
      showCustomSnackParRed('you need to enter numbers only', 'not phone number');
    } else if (password.isEmpty) {
      showCustomSnackParRed('enter your password ', 'empty field');
    } else if (password.length < 6) {
      showCustomSnackParRed(
          'short password must more than 6 characters', 'short password');
    } else {
      UserSingInModel userLoginModel = UserSingInModel(phone, password);
      authController.login_function(userLoginModel).then((status) {
        if (status.isSuccessful!) {
          print('Registration is done');
          Get.offAllNamed(AppRoutes.InitHome);
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
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return !controller.isloading
              ? Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                      width: width,
                    ),
                    SizedBox(
                      height: height * 0.25,
                      width: width * 0.6,
                      child: Image.asset(
                        'assets/image/logo part 1.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Hello',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'sign into your account',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  )),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    color:AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Colors.grey,
                                        offset: Offset(1, 1),
                                      )
                                    ],
                                    border: Border()),
                                child: TextFormField(
                                  controller: phoneController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    hintText: 'phone number',
                                    hintStyle:
                                        TextStyle(color: AppColors.buttonBackgroundColor,),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                        borderSide: BorderSide(
                                          color: AppColors.white,
                                          width: 1,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                        borderSide: BorderSide(
                                          color: AppColors.white,
                                          width: 1,
                                        )),
                                    prefixIcon: Icon(
                                      Icons.phone_android,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    color:AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Colors.grey,
                                        offset: Offset(1, 1),
                                      )
                                    ],
                                    border: Border()),
                                child: TextFormField(
                                  controller: passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'password',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFccc7c5)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                        borderSide: BorderSide(
                                          color: AppColors.white,
                                          width: 1,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                        borderSide: BorderSide(
                                          color: AppColors.white,
                                          width: 1,
                                        )),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets
                                          .only(), // add padding to adjust icon
                                      child: Icon(
                                        Icons.password,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: const Text(
                                      'forget your password? ',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                                width: width,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _loginMethod(controller);
                                },
                                child: Container(
                                  height: 70,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Sign in ',
                                      style: TextStyle(
                                          fontSize: 28, color: AppColors.white,),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 50,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.only(bottom: 15),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(() => SignUpPage(),
                                                  transition: Transition.fade);
                                            },
                                          text: 'Create ',
                                          style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 18)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                    backgroundColor: AppColors.white,
                  ),
                );
        }));
  }
}
