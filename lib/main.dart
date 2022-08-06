import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/Controller/recommended_products_controller.dart';
import 'package:shop_delivery_system/Controller/popular_products_controller.dart';
import 'package:shop_delivery_system/init/init.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/Testing/test.dart';
import 'package:shop_delivery_system/screen/payment/payment_page.dart';
import 'package:shop_delivery_system/services/model/order_model.dart';
import 'package:shop_delivery_system/utils/colors.dart';

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
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "lato"
          ),
         // home: PaymentPage(orderModel: OrderModel(id: 123,userId: 1),),
          initialRoute: AppRoutes.SS,
          getPages: AppRoutes.routes,
        );
      });
    });
  }
}
