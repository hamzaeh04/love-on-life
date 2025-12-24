import 'package:get/get.dart';
import 'package:love_on_life/outh_file/local_db_key.dart';

import '../utils/shared_prefrences_methods.dart';
import 'auth_controller.dart';

class SplashController extends GetxController {
  final String nextRoute;
  final prefs = SharedPreferencesMethod.storage;

  SplashController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () async {
      var token = await prefs.getString(LocalDBKeys.TOKEN);
      print(token);
      if (token == null || token.isEmpty) {
        Get.offNamed(nextRoute);
      } else {
        Get.offNamed("bottomnavbar");
      }
    });
  }
}

