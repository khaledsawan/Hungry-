import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/utils/AppConstants.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import '../../Services/model/cart_modle.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<CartModle> cartHistoryList = Get.find<CartController>().getcartHistory;
    Map<String, int> cartItemsPreOrder = {};
    if (cartHistoryList.isNotEmpty) {
      for (int i = 0; i < cartHistoryList.length; i++) {
        if (cartItemsPreOrder.containsKey(cartHistoryList[i].time!)) {
          cartItemsPreOrder.update(
              cartHistoryList[i].time!, (value) => ++value);
        } else {
          cartItemsPreOrder.addIf(true, cartHistoryList[i].time!, 1);
        }
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPreOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPreOrder = cartOrderTimeToList();
    int listCounter = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              'Your Cart History',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      body: Column(
        children: [

          Expanded(
              child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
            width: width,
            height: 150,
            child: cartHistoryList.isNotEmpty
                ? ListView(
                    children: [
                      for (int i = 0; i < itemsPreOrder.length; i++)
                        Container(
                          margin: const EdgeInsets.only(top: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: BigText(
                                  textbody: cartHistoryList[listCounter]
                                      .time
                                      .toString()
                                      .substring(0, 19),
                                  color: AppColors.titleColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      spacing: 0.1,
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPreOrder[i],
                                          (index) {
                                        if (listCounter <
                                            cartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                margin:
                                                const  EdgeInsets.only(right: 5),
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                    color: Colors.blue,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover, //
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                "/uploads/" +
                                                                cartHistoryList[
                                                                        index]
                                                                    .img!))),
                                              )
                                            : Container();
                                      })),
                                  Container(
                                    margin:const EdgeInsets.only(right: 5),
                                    width: 70,
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SmailText(
                                          textbody: ' Total  ',
                                          color: AppColors.mainColor,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        BigText(
                                          textbody:
                                              itemsPreOrder[i].toString() +
                                                  ' Items',
                                          color: AppColors.titleColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          width: 70,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: SmailText(
                                              textbody: 'order',
                                              size: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        SizedBox(
                            width: width - 17,
                            height: height * 0.22,
                            child: Image.asset("assets/image/empty_cart.png")),
                        BigText(
                          textbody: 'you are not order anything yet',
                          color: AppColors.textColor,
                        )
                      ],
                    )),
          ))
        ],
      ),
    );
  }
}
