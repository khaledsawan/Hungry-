import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/Controller/recommended_products_controller.dart';
import 'package:shop_delivery_system/Controller/popular_products_controller.dart';
import 'package:shop_delivery_system/init/init.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/Testing/test.dart';
import 'package:shop_delivery_system/screen/payment/payment_page.dart';
import 'package:shop_delivery_system/screen/setting/setting_page.dart';
import 'package:shop_delivery_system/services/model/order_model.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import 'package:shop_delivery_system/utils/localeString.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getstorageList;
    Get.find<CartController>().getcartHistory;
    return GetBuilder<RecommendedProductsController>(builder: (recommend) {
      return GetBuilder<PopularProductController>(builder: (popular) {
        return GetMaterialApp(
          title: 'food delivery System',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: AppColors.mainColor,),
         // home: SettingPage(),
         initialRoute: AppRoutes.SplashScreen,
          getPages: AppRoutes.routes,

          // language
          locale: const Locale('gu', 'IN'),
          translations: LocaleString(),
          fallbackLocale: const Locale('en', 'US'),
        );
      });
    });
  }
}
