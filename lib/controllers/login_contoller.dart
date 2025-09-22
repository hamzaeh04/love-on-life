import 'package:get/get.dart';

class LoginController extends GetxController {
  // observable bool for password visibility
  RxBool isPasswordVisible = true.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
