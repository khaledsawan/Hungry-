import 'dart:convert';
import 'package:get/get.dart';
import 'package:shop_delivery_system/utils/AppConstants.dart';
import '../model/cart_modle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  late SharedPreferences sharedpreferences;
  CartRepo({required this.sharedpreferences});

  List<String> cart = [];
  List<String> cart_history = [];

  void addToCartList(List<CartModle> cartList) {
    sharedpreferences.remove(AppConstants.CART_KEY);
    sharedpreferences.remove(AppConstants.CART_HISTORY_KEY);
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedpreferences.setStringList(AppConstants.CART_KEY, cart);
    getcartList();
  }

  List<CartModle> getcartList() {
    List<String>? CartString = [];
    if ( sharedpreferences.containsKey(AppConstants.CART_KEY)) {
      CartString = sharedpreferences.getStringList(AppConstants.CART_KEY);
      List<CartModle> CartModelList = [];
      CartString?.forEach((element) =>
          CartModelList.add(CartModle.fromJson(jsonDecode(element))));
      return CartModelList;
    } else {
      List<CartModle> CartModelList = [];
      return CartModelList;
    }
  }

  void addToHistory() async {
    cart.forEach((element) {
      cart_history.add(element);
    });
    clearCart();
    await sharedpreferences.setStringList(
        AppConstants.CART_HISTORY_KEY, cart_history);
    for (int i = 0; i < await getCartHistory().length; i++) {
      print(
          'there is Time /////////// ::' +await getCartHistory()[i].time.toString());
    }
  }

  void clearCart() async {
    await sharedpreferences.remove(AppConstants.CART_KEY);
  }
 clearSharedpreferences() async {
    cart_history = [];
    cart = [];
    await sharedpreferences.remove(AppConstants.CART_KEY) ;
    await sharedpreferences.remove(AppConstants.CART_HISTORY_KEY);
  }

  List<CartModle> getCartHistory() {
    List<String>? CartString = [];
    if (sharedpreferences.containsKey(AppConstants.CART_HISTORY_KEY)) {
      CartString =
          sharedpreferences.getStringList(AppConstants.CART_HISTORY_KEY);
      List<CartModle> CartModelList = [];
      CartString?.forEach((element) =>
          CartModelList.add(CartModle.fromJson(jsonDecode(element))));
      return CartModelList;
    } else {
      List<CartModle> CartModelList = [];
      return CartModelList;
    }
  }
}
