import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/model/user_profile_model.dart';
import 'package:shop_delivery_system/Services/repository/user_profile_repo.dart';
import 'package:shop_delivery_system/services/model/update_profile_model.dart';
import 'package:shop_delivery_system/widgets/Custom_snackpar/show_custom_snackpar_red.dart';

import '../Services/model/response_model.dart';
import '../widgets/Custom_snackpar/show_custom_snakpar_green.dart';

class UserProfileController extends GetxController implements GetxService {
  late UserProfileRepo userProfileRepo;
  UserProfileController({required this.userProfileRepo});
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  Future<ResponseModel> getProfileInfo() async {
    _isLoaded = true;
     ResponseModel responseModel;
    Response response = await userProfileRepo.getUserInfo();
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
    _isLoaded = true;
    ResponseModel responseModel;
    Response response = await userProfileRepo.updateUserProfile(updateProfileModel);
    if (response.statusCode == 200) {
      _isLoaded = false;
      responseModel = ResponseModel(massage: 'Successful', isSuccessful: true);
      showCustomSnackParGreen('profile update successful', '');
    } else {
      _isLoaded = false;
      _userProfileModel;
      responseModel = ResponseModel(massage: 'failed', isSuccessful: false);
      showCustomSnackParRed('try ageing', '');
    }
    _isLoaded = false;
return responseModel;
  }

}
