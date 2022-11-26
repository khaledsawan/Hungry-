import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/auth_controller.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/Controller/user_profile_controller.dart';
import 'package:shop_delivery_system/Services/model/cart_modle.dart';
import 'package:shop_delivery_system/controller/address_controller.dart';
import 'package:shop_delivery_system/controller/place_order_controller.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/cart/cart_history_page.dart';
import 'package:shop_delivery_system/services/model/place_order_model.dart';
import 'package:shop_delivery_system/widgets/App_Icons/app_icons.dart';
import 'package:shop_delivery_system/widgets/Custom_snackpar/show_custom_snackpar_red.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import '../../utils/AppConstants.dart';
import '../../utils/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return cartController.cartItems.isNotEmpty
            ? Container(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.30,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      child: Center(
                          child: BigText(
                              textbody:
                                  '\$' + cartController.totalprice.toString())),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().isAuth()) {
                          cartController.addToHistory();
                          if (Get.find<AddressController>()
                              .addressList
                              .isEmpty) {
                            showCustomSnackParRed(
                                'add your address pleas', 'ops');
                            Get.toNamed(AppRoutes.AddAddress);
                          } else {
                            var user = Get.find<UserProfileController>()
                                .userProfileModel;
                            var location =
                                Get.find<AddressController>().getUserAddress();
                            var cart = Get.find<CartController>().cartItems;
                            PlaceOrderModle placeOrderModel = PlaceOrderModle(
                                latitude: location.latitude,
                                orderAmount: 100.0,
                                scheduleAt: '',
                                distance: 10.0,
                                contactPersonNumber: user!.phone.toString(),
                                longitude: location.longitude,
                                contactPersonName: user.fName.toString(),
                                address: location.address,
                                cart: cart,
                                orderNote: 'not about the food ');
                            Get.find<PlaceOrderController>()
                                .placeOrder(_callback, placeOrderModel);
                          }
                        } else {
                          showCustomSnackParRed('you need to SignIn', 'ops');
                          Get.toNamed(AppRoutes.LoginPage);
                        }
                      },
                      child: Container(
                          width: width * 0.30,
                          height: 55,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              textbody: 'Check out',
                              color: AppColors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              );
      }),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcons(
                      icon: Icons.arrow_back_ios,
                      iconSize: 20,
                      backGroundColor: AppColors.mainColor,
                      iconColor: AppColors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.InitHome);
                        },
                        child: const AppIcons(
                          icon: Icons.home,
                          iconSize: 20,
                          backGroundColor: AppColors.mainColor,
                          iconColor: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const CartHistoryPage());
                        },
                        child: const AppIcons(
                          icon: Icons.shopping_cart,
                          iconSize: 20,
                          backGroundColor: AppColors.mainColor,
                          iconColor: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<CartController>(builder: (cartController) {
              var cartList = cartController.cartItems;
              return cartList.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return cartList.isEmpty
                            ? const Text('is Empty')
                            : cartBody(
                                index, height, cartList[index], cartController);
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                              height: height * 0.5,
                              width: width * 0.7,
                              child:
                                  Image.asset("assets/image/empty_cart.png")),
                          BigText(
                            textbody: 'nothing inside cart yat ',
                            color: AppColors.textColor,
                          )
                        ],
                      ));
            }),
          ),
        ],
      ),
    );
  }

  cartBody(int index, double height, CartModle cartItem,
      CartController cartController) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (cartItem.category.toString() == 'recommended') {
                Get.toNamed(AppRoutes.RecommendedPage,
                    arguments: cartItem.product!);
              } else {
                Get.toNamed(AppRoutes.PopularPage,
                    arguments: cartItem.product!);
              }
            },
            child: Container(
              height: height * 0.13,
              width: MediaQuery.of(context).size.width * 0.30,
              margin: const EdgeInsets.only(right: 8, left: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: AppColors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL + "/uploads/" + cartItem.img!),
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: height * 0.13,
              margin: const EdgeInsets.only(right: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  BigText(
                    textbody: cartItem.name!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmailText(
                    textbody: 'type',
                    color: AppColors.textColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        textbody: '\$ ' + cartItem.price.toString(),
                        color: Colors.red,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cartController.additem(
                                  cartItem.product!, 1, cartItem.category!);
                            },
                            child:const AppIcons(
                              icon: Icons.add,
                              backGroundColor: AppColors.white,
                              iconSize: 22,
                            ),
                          ),
                          BigText(textbody: cartItem.quantity.toString()),
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  cartController.additem(cartItem.product!, -1,
                                      cartItem.category!);
                                },
                                child:const AppIcons(
                                  icon: Icons.minimize,
                                  backGroundColor: AppColors.white,
                                  iconSize: 22,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _callback(bool isOrder, String massage, String orderId) {
  if (isOrder) {
    Get.offNamed(AppRoutes.Payment, arguments: [
      {"id": orderId},
      {"user_Id": Get.find<UserProfileController>().userProfileModel?.id!}
    ]);
  } else {
    showCustomSnackParRed(massage, '');
  }
}
