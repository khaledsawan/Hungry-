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
 Future<void> _loadResourses() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductsController>().getRecommendedProductList();
    print('Get.find<RecommendedProductsController>().popularProductList');
    print(Get.find<PopularProductController>().popularProductList);

 }

  @override
  Widget build(BuildContext context) {
   double width=MediaQuery.of(context).size.width;
   double height=MediaQuery.of(context).size.height;
    return RefreshIndicator(
      displacement: height*0.05,
      onRefresh:_loadResourses,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 30, right: 5, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin:EdgeInsets.only(left: 8),
                        child: BigText(
                          textbody: 'Syria',
                          color: AppColors.mainColor,
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            SmailText(
                              textbody: 'city',
                              color: Colors.black,
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
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(child: MainSilederPage())),
          ],
        ),
      ),
    );
  }
}
