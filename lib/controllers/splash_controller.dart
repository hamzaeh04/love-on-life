import 'package:get/get.dart';

class SplashController extends GetxController {
  final String nextRoute;

  SplashController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(nextRoute);
    });
  }
}
