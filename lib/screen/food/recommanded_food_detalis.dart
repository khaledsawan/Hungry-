import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/screen/cart/cart_page.dart';
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
    {
      ProductModal productModal = Get.arguments;
      Get.find<PopularProductController>()
          .initproduct(productModal, Get.find<CartController>());
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      return Scaffold(
          backgroundColor: Colors.white,
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
                        child: AppIcons(
                          icon: Icons.clear,
                          backgruondcolor: Colors.white,
                          iconSize: 23,
                        )),
                    GestureDetector(onTap: () {
                      Get.to(() => const CartPage());
                    }, child:
                        GetBuilder<CartController>(builder: (cartcontroller) {
                      return Stack(
                        children: [
                          AppIcons(
                            icon: Icons.shopping_cart_outlined,
                            backgruondcolor: Colors.white,
                            iconSize: 23,
                          ),
                          cartcontroller.totalquantity>0?Positioned(
                            left: 20,
                            right: 1,

                            child: Stack(children: [ AppIcons(
                              icon: Icons.circle,
                              iconSize: 18,
                              containerSize: 18,
                              iconColor: AppColors.mainColor,
                            ),
                              Positioned(
                                // right: ,
                                  top: 6,
                                  left: 4,
                                  child: SmailText(
                                    textbody: cartcontroller.totalquantity.toString(),
                                    color: Colors.blueGrey,
                                  )),],),
                          ):Container(),

                        ],
                      );
                    })),
                  ],
                ),
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 3, top: 3),
                    width: width,
                    height: height * 0.05,
                    decoration: const BoxDecoration(
                        color: Colors.white,
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
                expandedHeight: height * 0.4,
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
          bottomNavigationBar: GetBuilder<PopularProductController>(
              builder: (popularController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 60),
                          child: GestureDetector(
                            onTap: () {
                              popularController.setQuantity(false);
                            },
                            child: AppIcons(
                              icon: Icons.remove,
                              backgruondcolor: AppColors.mainColor,
                              containerSize: 40,
                              iconColor: Colors.white,
                            ),
                          )),
                      BigText(
                        textbody: '\$' +
                            productModal.price.toString() +
                            '  X  ' +
                            popularController.inCartItems.toString(),
                        size: 22,
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: 60),
                          child: GestureDetector(
                            onTap: () {
                              popularController.setQuantity(true);
                            },
                            child: AppIcons(
                              icon: Icons.add,
                              backgruondcolor: AppColors.mainColor,
                              containerSize: 40,
                              iconSize: 24,
                              iconColor: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                      decoration: const BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: AppIcons(
                              icon: Icons.heart_broken,
                              backgruondcolor: Colors.white,
                              iconColor: AppColors.mainColor,
                              iconSize: 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              popularController.addItem(
                                  productModal, 'recommended');
                            },
                            child: Container(
                              width: width * 0.45,
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
                                        '\$' + productModal.price.toString(),
                                    color: Colors.white,
                                  ),
                                  BigText(
                                    textbody: '| Add To Cart',
                                    color: Colors.white,
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
}
