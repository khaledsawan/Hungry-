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
      backgroundColor: Colors.white,
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartcontroller) {
        return cartcontroller.cartItems.isNotEmpty
            ? Container(
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
                      width: width * 0.30,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: BigText(
                              textbody:
                                  '\$' + cartcontroller.totalprice.toString())),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().isAuth()) {
                          cartcontroller.addToHistory();
                          if (Get.find<AddressController>()
                              .addressList
                              .isEmpty) {
                            ShowCustomSnackparRed('add your address pleas', 'ops');
                            Get.toNamed(AppRoutes.AddAddress);
                          } else {
                            var user = Get.find<UserProfileController>()
                                .userProfileModel;
                            var location =
                                Get.find<AddressController>().getUserAddress();
                            var cart = Get.find<CartController>().cartItems;
                            PlaceOrderModle placeOrderModle = PlaceOrderModle(
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
                                .placeorder(_callback, placeOrderModle);
                          }
                        } else {
                          ShowCustomSnackparRed('you need to SignIn', 'ops');
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
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
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
            margin: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcons(
                      icon: Icons.arrow_back_ios,
                      iconSize: 20,
                      backgruondcolor: AppColors.mainColor,
                      iconColor: Colors.white,
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
                        child: AppIcons(
                          icon: Icons.home,
                          iconSize: 20,
                          backgruondcolor: AppColors.mainColor,
                          iconColor: Colors.white,
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
                          Get.to(() => CartHistoryPage());
                        },
                        child: AppIcons(
                          icon: Icons.shopping_cart,
                          iconSize: 20,
                          backgruondcolor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<CartController>(builder: (cartcontroller) {
              var cartList = cartcontroller.cartItems;
              return cartList.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return cartList.isEmpty
                            ? const Text('is Empty')
                            : CartBody(
                                index, height, cartList[index], cartcontroller);
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
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

  CartBody(int index, double height, CartModle cartItem,
      CartController cartcontroller) {
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
                      color: Colors.white,
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
                              cartcontroller.additem(
                                  cartItem.product!, 1, cartItem.category!);
                            },
                            child: AppIcons(
                              icon: Icons.add,
                              backgruondcolor: Colors.white,
                              iconSize: 22,
                            ),
                          ),
                          BigText(textbody: cartItem.quantity.toString()),
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  cartcontroller.additem(cartItem.product!, -1,
                                      cartItem.category!);
                                },
                                child: AppIcons(
                                  icon: Icons.minimize,
                                  backgruondcolor: Colors.white,
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
    ShowCustomSnackparRed(massage, '');
  }
}
