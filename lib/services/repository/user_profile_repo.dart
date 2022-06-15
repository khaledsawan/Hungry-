import 'package:get/get.dart';
import 'package:shop_delivery_system/services/model/update_profile_model.dart';

import 'package:shop_delivery_system/utils/AppConstants.dart';

import '../api/api_client.dart';
import '../model/user_signup_model.dart';

class UserProfileRepo extends GetxService {
  late ApiClient apiClient;

  UserProfileRepo({required this.apiClient});
  Future<Response> updateUserProfile(
      UpdateProfileModel updateProfileModel) async {
    return await apiClient.postData(
        AppConstants.UPDATE_USER_PROFILE, updateProfileModel.tojson());
  }

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO);
  }
}
