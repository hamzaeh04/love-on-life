import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // needed for MediaType
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../outh_file/local_db_key.dart';
import '../utils/utility.dart';
import '../widgets/success_dialog.dart';
import 'auth_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Drawercontroller extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final BaseService baseService = BaseService();
  //late Rx<String> phoneNo = authController.fullPhoneNumber.value.obs;

  final TextEditingController editNameField = TextEditingController();
  final TextEditingController oldPassField = TextEditingController();
  final TextEditingController newPassField = TextEditingController();
  final TextEditingController confirmPassField = TextEditingController();

  String formatYear(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsedDate = DateTime.parse(date);
      return parsedDate.year.toString();
    } catch (e) {
      return '';
    }
  }

  Future<void> updateProfile(BuildContext context, {File? profilePicture}) async {
    try {
      EasyLoading.show(status: 'Updating Profile...');
      final uri = Uri.parse("${BaseService().baseURL}${ApiEndPoints.updateProfile}");
      print("API URL: $uri"); // <-- Print API URL

      final request = http.MultipartRequest('PATCH', uri);

      // Only sending full name and phone number
      request.fields['fullname'] = editNameField.text.trim();
      request.fields['phone'] = authController.fullPhoneNumber.value;

      if (profilePicture != null && profilePicture.existsSync()) {
        final fileName = profilePicture.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ));
        print("Profile Picture Added: $fileName"); // <-- Print file added
      }


      // Optional Auth Header
      final prefs = await SharedPreferences.getInstance();
      final bearerToken = prefs.getString(LocalDBKeys.TOKEN);
      if (bearerToken != null && bearerToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $bearerToken';
        print("Authorization Header Added");
      }

      // Send request
      final streamedResponse = await request.send().timeout(const Duration(seconds: 60));
      final responseString = await streamedResponse.stream.bytesToString();

      print("Raw Response: $responseString"); // <-- Print full response

      final responseMap = json.decode(responseString);
      final int statusCode = responseMap['statusCode'] ?? streamedResponse.statusCode;
      final bool success = responseMap['success'] ?? false;

      print("Parsed Response: $responseMap"); // <-- Print parsed response
      print("Status Code: $statusCode, Success: $success");

      if (success && statusCode == 201) {
        Utils.showToast(responseMap['message'] ?? "Profile updated", false);

        final data = responseMap['data'];
        if (data != null && data['fullname'] != null) {
          // 1. Local Storage update
          await prefs.setString(LocalDBKeys.USERFULLNAME, data['fullname']);
          await prefs.setString(LocalDBKeys.USERPROFILEPIC, data['profilePicture']);
          await prefs.setString(LocalDBKeys.PHONENUMBER, authController.fullPhoneNumber.value);

          // 2. AuthController ke variables ko foran update karein taake UI refresh ho
          authController.userProfilePic.value = data['profilePicture'] ?? "";
          authController.userName.value = data['fullname'] ?? "";

          // 3. Picked image ko null kar dein taake wo Network image dikhana shuru karde
          authController.profilePicture.value = null;

          authController.loadUserData();
          print(data);
          print(data['fullname']);
          print("API PIC : ${data['profilePicture']}");
          print('Old Pic${authController.userProfilePic.value}');
        }

        successDialog(context, "Done!", "Profile has been updated successfully.", "Ok", () {
          Get.back();
          Get.back();
        });
        clearUpdateProfileFields();
        return;
      }

      // Error handling
      Utils.showToast(responseMap['message'] ?? "Profile update failed", true);

    } on TimeoutException {
      Utils.showToast("Request timed out", true);
    } on SocketException {
      Utils.showToast("No Internet connection", true);
    } catch (e) {
      Utils.showToast("Unexpected error: $e", true);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> changePassword(BuildContext context) async {
    final body = {
      "oldPassword": oldPassField.text.trim(),
      "newPassword": newPassField.text.trim(),
      "confirmPassword": confirmPassField.text.trim(),
    };

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.changePassword,
        body,
        loading: true,
      );

      // Internet issue
      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      final int statusCode = response['statusCode'] ?? 0;

      // Success
      if (statusCode >= 200 && statusCode < 300) {
        Utils.showToast(response['message'] ?? 'OTP Verified Successfully', false);

        // Go to Reset Password screen
        successDialog(context, "Done!", "Password has been Updated successfully.", "Ok", (){
          Get.back();
          Get.back();
          clearChangePassFields();
        });
        return;
      }

      // Error
      Utils.showToast(response['message'] ?? 'Password hasn\'t changed', true);

    } catch (e) {
      Utils.showToast("Error: $e", true);
    }
  }

  void clearChangePassFields(){
    oldPassField.clear();
    newPassField.clear();
    confirmPassField.clear();
  }
  void clearUpdateProfileFields(){
    editNameField.clear();
    authController.fullPhoneNumber.value = '';
    authController.phoneController.clear();
  }
}
