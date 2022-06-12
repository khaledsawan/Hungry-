import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/widgets/button/custom_button.dart';

class OrderSuccessPage extends StatelessWidget {
  final String order_Id;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.order_Id, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {});
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                status == 1
                    ? "assets/image/checked.png"
                    : "assets/image/warning.png",
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Text(
                status == 1
                    ? 'You placed the order successfully'
                    : 'Your order failed',
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failed order',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).disabledColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomButton(
                  buttonText: 'Back to Home',
                  onPressed: () => Get.offNamed(AppRoutes.InitHome),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
