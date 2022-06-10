import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/Controller/popular_products_controller.dart';
import 'package:shop_delivery_system/screen/cart/cart_page.dart';
import 'package:shop_delivery_system/widgets/App_Icons/app_icons.dart';
import 'package:shop_delivery_system/widgets/text/descriptiontextwidget.dart';
import '../../Services/model/product_model.dart';
import '../../utils/AppConstants.dart';
import '../../utils/colors.dart';
import '../../widgets/icon_and_text widgets/icons_text_widgets.dart';
import '../../widgets/text/big_text.dart';
import '../../widgets/text/smail_text.dart';

class PopularFoodDetails extends StatefulWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  Widget build(BuildContext context) {
    ProductModal productModal = Get.arguments;
    Get.find<PopularProductController>().initproduct(productModal, Get.find<CartController>());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL + "/uploads/" + productModal.img!,
                    ),
                  )),
                )),
            Positioned(
                left: 20,
                top: 40,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcons(
                        icon: Icons.arrow_back_ios,
                      ),
                    ),
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
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: height * 0.40 - 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            textbody: productModal.name!,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    productModal.stars!,
                                    (index) => const Icon(Icons.star,
                                        color: Colors.cyan, size: 15)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SmailText(
                                  textbody: "4.5", color: AppColors.textColor),
                              const SizedBox(
                                width: 10,
                              ),
                              SmailText(
                                  textbody: "1287 comments",
                                  color: AppColors.textColor)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          IconsTextWidgets(
                              food_name: 'normal',
                              location: '1.2km',
                              food_timer: '5m'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                color: Colors.white,
                                width: width,
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                child: BigText(textbody: 'Introduce')),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Container(
                                color: Colors.white,
                                width: width,
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 5),
                                child: DescriptionTextWidget(
                                    text: productModal.description!)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartcontroller) {
          return GetBuilder<PopularProductController>(builder: (popularcontroller) {
            return Container(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
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
                    width: width * 0.31,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: IconButton(
                                onPressed: () {
                                  popularcontroller.setQuantity(false);
                                },
                                icon: const Icon(Icons.minimize))),
                        BigText(textbody: popularcontroller.inCartItems.toString()),
                        IconButton(
                            onPressed: () {
                              popularcontroller.setQuantity(true);
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularcontroller.addItem(productModal,'Popular');
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
                          BigText(textbody: '\$' +productModal.price.toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          BigText(textbody: 'Add To Cart'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        }));
  }
}
