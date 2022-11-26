import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import '../../Controller/popular_products_controller.dart';
import '../../Controller/recommended_products_controller.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  _loadRes() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductsController>().getRecommendedProductList();
  }

  @override
  void initState() {
    _loadRes();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    Timer(const Duration(seconds: 3), () => Get.toNamed(AppRoutes.InitHome));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width * 0.7,
          height: height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/image/logo part 1.png")),
              Center(child: Image.asset("assets/image/logo part 2.png")),
            ],
          ),
        ),
      ),
    );
  }
}
