import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/model/user_profile_model.dart';
import 'package:shop_delivery_system/Services/repository/user_profile_repo.dart';

import '../Services/model/response_model.dart';

class UserProfileController extends GetxController implements GetxService {
  late UserProfileRepo userProfileReop;
  UserProfileController({required this.userProfileReop});
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  Future<ResponseModel> getProfileInfo() async {
    print('/////getProfileInfo');
    _isLoaded = true;
     ResponseModel responseModel;
    Response response = await userProfileReop.getUserInfo();
    if (response.statusCode == 200) {
      _isLoaded = false;
      _userProfileModel = UserProfileModel.fromJson(response.body);
      responseModel = ResponseModel(massage: 'Successful', isSuccessful: true);
    } else {
      _isLoaded = false;
      _userProfileModel;
      responseModel = ResponseModel(massage: 'failed', isSuccessful: false);
    }
    _isLoaded = false;
    update();
    return responseModel;
  }
}
