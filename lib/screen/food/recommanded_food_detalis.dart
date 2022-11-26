import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/recommended_products_controller.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/widgets/App_Icons/app_icons.dart';
import 'package:shop_delivery_system/widgets/text/descriptiontextwidget.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import '../../Controller/cart_controller.dart';
import '../../Controller/popular_products_controller.dart';
import '../../Services/model/product_model.dart';
import '../../utils/AppConstants.dart';
import '../../utils/colors.dart';
import '../../widgets/text/big_text.dart';

class RecommendedFoodDetails extends StatefulWidget {
  const RecommendedFoodDetails({Key? key}) : super(key: key);

  @override
  State<RecommendedFoodDetails> createState() => _RecommendedFoodDetailsState();
}

class _RecommendedFoodDetailsState extends State<RecommendedFoodDetails> {
  @override
  Widget build(BuildContext context) {

      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      ProductModal productModal = Get.arguments;
      PopularProductController controller =
          Get.find<PopularProductController>();

      CartController cartController = Get.find<CartController>();
      controller.initproduct(productModal, cartController);
      return Scaffold(
          backgroundColor: AppColors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const AppIcons(
                          icon: Icons.arrow_back,
                          backGroundColor: AppColors.white,
                          iconSize: 23,
                        )),
                    GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.CartScreen),
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          return Stack(
                            children: [
                              const AppIcons(
                                icon: Icons.shopping_cart_outlined,
                                backGroundColor: AppColors.white,
                                iconSize: 23,
                              ),
                              cartController.totalquantity > 0
                                  ? Positioned(
                                      left: 20,
                                      right: 1,
                                      child: Stack(
                                        children: [
                                          const AppIcons(
                                            icon: Icons.circle,
                                            iconSize: 22,
                                            containerSize: 16,
                                            iconColor: AppColors.mainColor,
                                          ),
                                          Positioned(
                                              // right: ,
                                              top: 6,
                                              left: 4,
                                              child: SmailText(
                                                textbody: cartController
                                                    .totalquantity
                                                    .toString(),
                                                color: AppColors.mainBlackColor,
                                              )),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          );
                        })),
                  ],
                ),
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 3, top: 3, left: 6),
                    width: width,
                    height: height * 0.05,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: BigText(
                      textbody: productModal.name!,
                      size: 28,
                    ),
                  ),
                ),
                backgroundColor: AppColors.yellowColor,
                expandedHeight: height * 0.55,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    AppConstants.BASE_URL + "/uploads/" + productModal.img!,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    DescriptionTextWidget(text: productModal.description!),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: GetBuilder<RecommendedProductsController>(
              builder: (recommendController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: GestureDetector(
                                onTap: () {
                                  recommendController.setQuantity(false);
                                },
                                child: const AppIcons(
                                  icon: Icons.remove,
                                  backGroundColor: AppColors.mainColor,
                                  containerSize: 40,
                                  iconColor: AppColors.white,
                                ),
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          BigText(
                            textbody:
                                recommendController.inCartItems.toString(),
                            size: 22,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 60),
                              child: GestureDetector(
                                onTap: () {
                                  recommendController.setQuantity(true);
                                },
                                child: const AppIcons(
                                  icon: Icons.add,
                                  backGroundColor: AppColors.mainColor,
                                  containerSize: 40,
                                  iconSize: 24,
                                  iconColor: AppColors.white,
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BigText(
                            size: 24,
                            textbody: '\$' + productModal.price.toString()),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.buttonBackgroundColor,
                            ),
                            child: const AppIcons(
                              icon: Icons.heart_broken,
                              backGroundColor: AppColors.white,
                              iconColor: AppColors.mainColor,
                              iconSize: 30,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.mainColor),
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.buttonBackgroundColor,
                            ),
                            child: BigText(
                              textbody: 'Buy Now !',
                              color: AppColors.mainColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              recommendController.addItem(productModal);
                            },
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.mainColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    textbody:
                                        '\$' + productModal.price!.toString(),
                                    color: AppColors.white,
                                  ),
                                  BigText(
                                    textbody: '| Add To Cart',
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }));
    }

}
