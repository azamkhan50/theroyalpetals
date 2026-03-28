import 'package:get/get.dart';
import 'package:royalpetals/views/auth/login._screen.dart';
import 'package:royalpetals/views/auth/shopify_login_screen.dart';
import 'package:royalpetals/views/home/home_screen.dart';


class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _goToLogin();
  }

  void _goToLogin() async {

    // wait 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // navigate to login screen
    Get.off(() =>  ShopifyLoginScreen());

  }

}