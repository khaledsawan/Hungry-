import 'package:get/get.dart';

import '../../utils/AppConstants.dart';
import '../api/api_client.dart';

class RecommendedProductsRepo extends GetxService{
  late final ApiClient apiClient;

  RecommendedProductsRepo({required this.apiClient});

  Future<Response> GetProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
}