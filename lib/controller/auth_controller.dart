import 'package:get/get.dart';
import 'package:shop_delivery_system/Services/model/user_signin_model.dart';
import 'package:shop_delivery_system/Services/model/user_signup_model.dart';
import 'package:shop_delivery_system/Services/repository/auth_repo.dart';
import 'package:shop_delivery_system/utils/AppConstants.dart';
import '../Services/model/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  SharedPreferences sharedPreferences;
  AuthController({required this.authRepo,required this.sharedPreferences});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registerMethod(UserSignUpModel userSignUpModel) async {
    _isLoading = true;
    ResponseModel responseModel;
    Response response = await authRepo.registeration(userSignUpModel);
    if (response.statusCode == 200) {
      _isLoading = true;
      responseModel =
          ResponseModel(massage: response.body["token"], isSuccessful: true);
      authRepo.saveUserToken(response.body["token"]);
      sharedPreferences.setString(AppConstants.TOKEN, response.body["token"].toString());
      saveUserPhoneAndPassword(
          userSignUpModel.phone!, userSignUpModel.password!);
    } else {
      responseModel =
          ResponseModel(massage: response.statusText!, isSuccessful: false);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginMethod(UserSingInModel userLoginModel) async {
    _isLoading = true;
    ResponseModel responseModel;
    Response response = await authRepo.login_function(userLoginModel);
    if (response.statusCode == 200) {
      _isLoading = true;
      responseModel = ResponseModel(massage: response.body["token"], isSuccessful: true);
      authRepo.saveUserToken(response.body["token"]);
      sharedPreferences.setString(AppConstants.TOKEN, response.body["token"].toString());
      saveUserPhoneAndPassword(userLoginModel.phone!, userLoginModel.password!);
    } else {
      responseModel =
          ResponseModel(massage: response.statusText!, isSuccessful: false);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  saveUserPhoneAndPassword(String phone, String password) {
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

  clearUserAuth() async {
    await authRepo.clearUserAuth();
    update();
  }

  bool isAuth() {
    return authRepo.isAuth();
  }
}
