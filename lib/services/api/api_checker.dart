import 'package:get/get.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/widgets/Custom_snackpar/show_custom_snackpar.dart';

class ApiChecker{
  static void checkerApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(AppRoutes.LoginPage);
    }else{
      ShowCustomSnackpar(response.statusText!.toString(), '');
    }
  }
}