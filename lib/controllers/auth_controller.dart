import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool forgotPassword = false.obs;
  RxBool isVerified = false.obs;
  final Rxn<Country> selectedCountry = Rxn<Country>();

  RxString countryCode = "+1".obs;
  RxString flagPath =
      "packages/country_icons/icons/flags/png100px/us.png".obs;


  /// LogIn Textfields controller
  final TextEditingController loginEmailField = TextEditingController();
  final TextEditingController loginPasswordField = TextEditingController();

  void openPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        selectedCountry.value = country;

        flagPath.value =
        "packages/country_icons/icons/flags/png100px/${country.countryCode.toLowerCase()}.png";

        countryCode.value = "+${country.phoneCode}";
      },
    );
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
