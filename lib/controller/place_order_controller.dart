import 'package:get/get.dart';
import 'package:shop_delivery_system/services/model/place_order_model.dart';
import 'package:shop_delivery_system/services/repository/order_repo.dart';

class PlaceOrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  PlaceOrderController({required this.orderRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(Function callback, PlaceOrderModle placeOrderModel) async {
    _isLoading = true;
    Response response = await orderRepo.Place_Order(placeOrderModel);
    if (response.statusCode == 200) {
      _isLoading = true;
      String massage = response.body['massage'];
      String order_Id = response.body['order_Id'];
      callback(true, massage, order_Id);
    } else {
      _isLoading = true;
      callback(false, response.statusText!, '-1');
    }
  }
}
