import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/api/api_client.dart';
import 'package:shop_delivery_system/services/model/place_order_model.dart';
import 'package:shop_delivery_system/utils/AppConstants.dart';

class OrderRepo extends GetxService {
  ApiClient apiClient;
  OrderRepo({required this.apiClient});
  Future<Response> Place_Order(PlaceOrderModle placeOrderModle) async {
    return await apiClient.postData(
        AppConstants.PLACE_ORDER_URI, placeOrderModle.toJson());
  }
}
