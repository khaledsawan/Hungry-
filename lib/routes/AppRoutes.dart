import 'package:get/get.dart';
import 'package:shop_delivery_system/screen/food/popular_food_details.dart';
import 'package:shop_delivery_system/screen/food/recommanded_food_detalis.dart';
import 'package:shop_delivery_system/screen/home/home_page.dart';
import 'package:shop_delivery_system/screen/location/address_page.dart';
import 'package:shop_delivery_system/screen/payment/payment_page.dart';
import 'package:shop_delivery_system/screen/splach_screen/splash_screen.dart';
import 'package:shop_delivery_system/screen/splach_screen/splash_screen_v2.dart';
import 'package:shop_delivery_system/screen/user%20auth/sign_in_page.dart';
import 'package:shop_delivery_system/screen/user%20auth/sign_up_page.dart';
import 'package:shop_delivery_system/screen/user%20profile/edit_profile_page.dart';
import 'package:shop_delivery_system/screen/we/about_us_page.dart';
import 'package:shop_delivery_system/screen/we/support_page.dart';
import 'package:shop_delivery_system/services/model/order_model.dart';
import '../screen/cart/cart_page.dart';
import '../screen/location/pick_address_map.dart';
import '../screen/payment/order_success_page.dart';

class AppRoutes {
  static const String InitHome = "/";
  static const String RecommendedPage = "/recommended-page";
  static const String PopularPage = "/popular-page";
  static const String CartScreen = "/cart-page";
  static const String SplashScreen = "/splash-screen";
  static const String SS = "/splash-screen-v2";
  static const String LoginPage = "/login-page";
  static const String Registerpage = "/register-page";
  static const String Addresspage = "/address-page";
  static const String AddAddress = "/add-address";
  static const String AddressPike = "/address-pike";
  static const String Payment = "/payment";
  static const String OrderSuccess = "/ordersuccess";
  static const String EditProfile = "/edit_profile";
  static const String Support = "/support_page";
  static const String Aboutpage = "/about_us_page";

  static String getAddressPage() => AddAddress;
  static final routes = [
    GetPage(
        name: InitHome,
        page: () => const HomePage(),
        transition: Transition.fade),
    GetPage(
        name: AddressPike,
        page: () => const PickAddressMap(
              fromAddress: null,
              fromSignup: null,
              googleMapController: null,
            ),
        transition: Transition.fadeIn),
    GetPage(
        name: Addresspage,
        page: () =>const AddressPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: SplashScreen,
        page: () =>const SplachScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: SS,
        page: () => SplashScreenV2(),
        transition: Transition.fadeIn),
    GetPage(
        name: LoginPage,
        page: () =>const SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: Registerpage,
        page: () => SignUpPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: CartScreen,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: RecommendedPage,
        page: () => const RecommendedFoodDetails(),
        transition: Transition.fadeIn),
    GetPage(
      name: PopularPage,
      page: () => const PopularFoodDetails(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AddAddress,
      page: () {
        return const AddressPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Payment,
      page: () {
        return PaymentPage(
            orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['user_Id']!),
        ));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: OrderSuccess,
      page: () {
        return OrderSuccessPage(
            order_Id: Get.parameters['id']!,
            status: Get.parameters["status"].toString().contains("success")
                ? 1
                : 0);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: EditProfile,
        page: () => EditProfilePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: Support,
        page: () => const SupportPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: Aboutpage,
        page: () => const AboutUsPage(),
        transition: Transition.fadeIn),
  ];
}
