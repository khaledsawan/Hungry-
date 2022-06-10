import 'package:get/get.dart';
import 'package:shop_delivery_system/screen/food/popular_food_details.dart';
import 'package:shop_delivery_system/screen/food/recommanded_food_detalis.dart';
import 'package:shop_delivery_system/screen/home/home_page.dart';
import 'package:shop_delivery_system/screen/location/address_page.dart';
import 'package:shop_delivery_system/screen/splach_screen/splash_screen.dart';
import 'package:shop_delivery_system/screen/user%20auth/sign_in_page.dart';
import 'package:shop_delivery_system/screen/user%20auth/sign_up_page.dart';

import '../screen/cart/cart_page.dart';
import '../screen/location/pick_address_map.dart';


class AppRoutes {
  static const String InitHome = "/";
  static const String RecommendedPage = "/recommended-page";
  static const String PopularPage = "/popular-page";
  static const String CartScreen = "/cart-page";
  static const String SplashScreen = "/splash-screen";
  static const String LoginPage = "/login-page";
  static const String Registerpage = "/register-page";
  static const String Addresspage = "/address-page";
  static const String AddAddress = "/add-address";
  static const String AddressPike = "/address-pike";


  static String getAddressPage()=>'$AddAddress';
  static final routes = [

    GetPage(
        name: InitHome,
        page: () => HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AddressPike,
        page: () =>  PickAddressMap(fromAddress: null, fromSignup: null, googleMapController: null,),
        transition: Transition.fadeIn),
    GetPage(
        name: Addresspage,
        page: () => AddressPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: SplashScreen,
        page: () => SplachScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: LoginPage,
        page: () => SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: Registerpage,
        page: () => SignUpPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: CartScreen,
        page: () => CartPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: RecommendedPage,
        page: () => const RecommendedFoodDetails(),
        transition: Transition.fadeIn),
    GetPage(
      name: PopularPage,
      page: () => PopularFoodDetails(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AddAddress,
      page: () {return AddressPage();},
      transition: Transition.fadeIn,
    ),

  ];
}
