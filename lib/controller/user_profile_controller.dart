import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/model/user_profile_model.dart';
import 'package:shop_delivery_system/Services/repository/user_profile_repo.dart';
import 'package:shop_delivery_system/services/model/update_profile_model.dart';
import 'package:shop_delivery_system/widgets/Custom_snackpar/show_custom_snackpar_red.dart';

import '../Services/model/response_model.dart';
import '../widgets/Custom_snackpar/show_custom_snakpar_green.dart';

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
  Future<ResponseModel> updateUserProfile(UpdateProfileModel updateProfileModel) async {
    print('/////updateUserProfile');
    _isLoaded = true;
    ResponseModel responseModel;
    Response response = await userProfileReop.updateUserProfile(updateProfileModel);
    if (response.statusCode == 200) {
      _isLoaded = false;
      responseModel = ResponseModel(massage: 'Successful', isSuccessful: true);
      ShowCustomSnackparGreen('profile update successful', '');
    } else {
      _isLoaded = false;
      _userProfileModel;
      responseModel = ResponseModel(massage: 'failed', isSuccessful: false);
      ShowCustomSnackparRed('try ageing', '');
    }
    _isLoaded = false;
    update();
    return responseModel;
  }

}
