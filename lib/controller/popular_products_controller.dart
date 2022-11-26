import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/cart_controller.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import '../Services/model/product_model.dart';
import '../Services/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  late PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  late List<dynamic> _productList = [];
  List<dynamic> get popularProductList => _productList;

  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

 String priceToString(int itemPrice){
 return (inCartItems*itemPrice).toString();
 }

  Future<void> getPopularProductList() async {
    _isLoaded = true;
    Response response = await popularProductRepo.GetProductList();
    if (response.statusCode == 200) {
      _productList = [];
      _productList.addAll(Product.fromJson(response.body).products);
      _isLoaded = false;
      update();
    } else {
      _isLoaded = false;
    }
    _isLoaded = false;
  }

  void initProduct(ProductModal productModal, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    bool exist = false;
    exist = _cartController.isExset(productModal);
    if (exist) {
      _inCartItems = cart.cartitemsquantity(productModal);
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if ((_inCartItems + _quantity == 20)) {
        _quantity = 20;
      } else {
        _quantity = checkQuantity(_quantity + 1);
      }
    } else {
      if ((_inCartItems + _quantity == 0)) {
        _quantity = 0;
      } else {
        _quantity = checkQuantity(_quantity - 1);
      }
    }
    update();
  }

  void addItem(ProductModal productModal, String category) {
    _cartController.additem(productModal, _quantity, category);
    _quantity = 0;
    _inCartItems = _cartController.cartitemsquantity(productModal);
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + _quantity) < 0) {
      Get.snackbar('Item count', 'You can\'t put less than 0',
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
      return 0;
    } else if ((_inCartItems + _quantity) > 20) {
      Get.snackbar('Item count', 'You can\'t put an food',
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
      return 20;
    }
    return quantity;
  }

  int get totalItems {
    return _cartController.totalquantity;
  }
}
