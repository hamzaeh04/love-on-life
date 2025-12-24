import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/payment_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    }, permanent: true);

  }
}