import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/repository/recommended_product_repo.dart';
import '../Services/model/product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class RecommendedProductsController extends GetxController {
  late RecommendedProductsRepo recommendProductRepo;

  RecommendedProductsController({required this.recommendProductRepo});

  late List<ProductModal> _productList = [];
  List<ProductModal> get recommendedProductList => _productList;

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

  Future<void> getRecommendedProductList() async {
    Response response = await recommendProductRepo.GetProductList();
    _isLoaded = true;
    if (response.statusCode == 200) {
      _productList = [];
      _productList.addAll(Product.fromJson(response.body).products);
      _isLoaded = false;
      update();
    } else {
      _isLoaded = false;
    }
  }

  void initProduct(ProductModal productModal, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    bool exist = false;
    exist = _cartController.isExit(productModal);
    if (exist) {
      _inCartItems = cart.cartItemsQuantity(productModal);
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  void addItem(ProductModal productModal) {
    _cartController.addItem(productModal, _quantity, 'recommended');
    _quantity = 0;
    _inCartItems = _cartController.cartItemsQuantity(productModal);
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + _quantity) < 0) {
      Get.snackbar('Item count', 'You can\'t put less than 0',
          colorText: AppColors.white, backgroundColor: AppColors.mainColor);
      return 0;
    } else if ((_inCartItems + _quantity) > 20) {
      Get.snackbar('Item count', 'You can\'t put an food',
          colorText: AppColors.white, backgroundColor: AppColors.mainColor);
      return 20;
    }
    return quantity;
  }

  int get totalItems {
    return _cartController.totalQuantity;
  }

}
