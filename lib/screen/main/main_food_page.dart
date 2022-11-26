import 'package:flutter/material.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import '../../Controller/popular_products_controller.dart';
import '../../Controller/recommended_products_controller.dart';
import 'main_silder_page.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
 Future<void> _loadRes() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductsController>().getRecommendedProductList();

 }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:_loadRes,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: AppColors.white,
                margin: const EdgeInsets.only(top: 0, right: 5, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin:const EdgeInsets.only(left: 8),
                          child: BigText(
                            textbody: 'Syria',
                            color: AppColors.mainColor,
                          ),
                        ),
                        Container(
                          margin:const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              SmailText(
                                textbody: 'city',
                                color:AppColors.black,
                              ),
                              const Icon(
                                Icons.arrow_drop_down_rounded,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.search,
                        size: 30,
                        color:AppColors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            const  Expanded(child: SingleChildScrollView(child: MainSliderPage())),
            ],
          ),
        ),
      ),
    );
  }
}
