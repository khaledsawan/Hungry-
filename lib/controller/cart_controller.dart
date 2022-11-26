import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/model/cart_modle.dart';
import 'package:shop_delivery_system/Services/model/product_model.dart';
import 'package:shop_delivery_system/Services/repository/cart_repo.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModle> _cartItemsMap = {};
  Map<int, CartModle> get cartItemsMap => _cartItemsMap;

  List<CartModle> storageList = [];
  List<CartModle> storageHistoryList = [];

  Map<String, int> cartItemsPreOrder = {};
  List<int> _orderTime = [];
  List<int> get orderTime => _orderTime;

  addItem(ProductModal productModal, int quantity, String category) {
    var totalQuantity = 0;
    if (_cartItemsMap.containsKey(productModal.id)) {
      _cartItemsMap.update(productModal.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModle(
            id: value.id,
            price: value.price,
            img: value.img,
            name: value.name,
            category: category,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: productModal);
      });
      if (totalQuantity <= 0) {
        _cartItemsMap.remove(productModal.id);
      }
    } else if (quantity > 0) {
      _cartItemsMap.putIfAbsent(
          productModal.id!,
          () => CartModle(
              id: productModal.id,
              price: productModal.price,
              img: productModal.img,
              name: productModal.name,
              quantity: quantity,
              category: category,
              isExist: true,
              time: DateTime.now().toString(),
              product: productModal));
    } else {
      Get.snackbar('Item count', 'you should add item to cart !',
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
    }
    cartRepo.addToCartList(cartItems);
    update();
  }

  bool isExit(ProductModal productModal) {
    return cartItemsMap.containsKey(productModal.id) ? true : false;
  }

  int cartItemsQuantity(ProductModal productModal) {
    int itemQuantity = 0;
    cartItemsMap.forEach((key, value) {
      if (key == productModal.id) {
        itemQuantity = value.quantity!;
      }
    });
    return itemQuantity;
  }

  int get totalQuantity {
    int totalQuantity = 0;
    if(_cartItemsMap.isNotEmpty){
      _cartItemsMap.forEach((key, value) {
        totalQuantity += value.quantity!;
      });}

    return totalQuantity;
  }

  List<CartModle> get cartItems {
    return _cartItemsMap.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalPrice {
    int totaling = 0;
    _cartItemsMap.forEach((key, value) {
      totaling = value.quantity! * value.price! + totaling;
    });
    return totaling;
  }

  List<CartModle> get getStorageList {
    setListCartStorage = cartRepo.getcartList();
    return storageList;
  }

  set setListCartStorage(List<CartModle> items) {
    storageList = items;
    for (var element in storageList) {
      _cartItemsMap.putIfAbsent(element.product!.id!, () => element);
    }
  }

  void addToHistory() {
    cartRepo.addToHistory();
    clear();
  }

  void clear() {
    _cartItemsMap = {};
    update();
  }

  List<CartModle> get getCartHistory {
    return cartRepo.getCartHistory();
  }
  clearSharedPreferences()async {
  await  cartRepo.clearSharedpreferences();
  clear();
  storageList = [];
  storageHistoryList = [];
  update();
  }
}
