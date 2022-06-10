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

  additem(ProductModal productModal, int quantity, String category) {
    var totalquantity = 0;
    if (_cartItemsMap.containsKey(productModal.id)) {
      _cartItemsMap.update(productModal.id!, (value) {
        totalquantity = value.quantity! + quantity;
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
      if (totalquantity <= 0) {
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

  bool isExset(ProductModal productModal) {
    return cartItemsMap.containsKey(productModal.id) ? true : false;
  }

  int cartitemsquantity(ProductModal productModal) {
    int itemquantity = 0;
    cartItemsMap.forEach((key, value) {
      if (key == productModal.id) {
        itemquantity = value.quantity!;
      }
    });
    return itemquantity;
  }

  int get totalquantity {
    int totalquantity = 0;
    if(_cartItemsMap.isNotEmpty){
      _cartItemsMap.forEach((key, value) {
        totalquantity += value.quantity!;
      });}

    return totalquantity;
  }

  List<CartModle> get cartItems {
    return _cartItemsMap.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalprice {
    int totaling = 0;
    _cartItemsMap.forEach((key, value) {
      totaling = value.quantity! * value.price! + totaling;
    });
    return totaling;
  }

  List<CartModle> get getstorageList {
    setListCart_Storage = cartRepo.getcartList();
    return storageList;
  }

  set setListCart_Storage(List<CartModle> items) {
    storageList = items;
    for (var element in storageList) {
      _cartItemsMap.putIfAbsent(element.product!.id!, () => element);
    }
  }

  // set setListCart_Storage_History(List<CartModle> items) {
  //   storageHistoryList = items;
  //
  //   for (var element in storageHistoryList) {
  //     _cartItemsMap.putIfAbsent(element.product!.id!, () => element);
  //   }
  // }

  void addToHistory() {
    cartRepo.addToHistory();
    clear();
  }

  void clear() {
    _cartItemsMap = {};
    update();
  }

  List<CartModle> get getcartHistory {
    return cartRepo.getCartHistory();
  }
  clearsharedpreferences()async {
  await  cartRepo.clearSharedpreferences();
  clear();
  storageList = [];
  storageHistoryList = [];
  update();
  }

  // List<CartModle> get getcartHistory_listed {
  //   List<CartModle> storageHistoryListListed = [];
  //   for (int i = 0; i < storageHistoryList.length; i++) {
  //     //storageHistoryList.contains();
  //   }
  //   return storageHistoryListListed;
  // }

// Map<String,int> get preorderListSection{
//   List<CartModle> CartHistoryList = cartRepo.getcartHistory();
//   for (int i = 0; i < CartHistoryList.length; i++) {
//     if (cartItemsPreOrder.containsKey(CartHistoryList[i].time)) {
//       cartItemsPreOrder.update(
//           CartHistoryList[i].time.toString(), (value) => ++value);
//     } else {
//       cartItemsPreOrder.update(
//           CartHistoryList[i].time.toString(), (value) => 1);
//     }
//   }
//   List<int> cartOrderTimeToList(){
//     return cartItemsPreOrder.entries.map((e) => e.value).toList();
//   }
//    _orderTime=cartOrderTimeToList();
//
//   return   cartItemsPreOrder;
// }

}
