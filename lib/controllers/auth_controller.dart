import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import '../widgets/success_dialog.dart';

class AuthController extends GetxController {

  var userName = "".obs;
  var userProfilePic = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var date = "".obs;
  String resetToken = '';

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    editProfileEmail.text = userEmail.value;
    // requestInitialPermissions(); // 👈 THIS

  }

  void loadUserData() {
    final prefs = SharedPreferencesMethod.storage;
    userName.value = prefs.getString(LocalDBKeys.USERFULLNAME) ?? "";
    userProfilePic.value = prefs.getString(LocalDBKeys.USERPROFILEPIC) ?? "";
    userEmail.value = prefs.getString(LocalDBKeys.USEREMAIL) ?? "";
    userPhone.value = prefs.getString(LocalDBKeys.PHONENUMBER) ?? "";
  }
  /// Password visibility
  RxBool isPasswordVisible = true.obs;
  var fullPhoneNumber = "".obs;
  var otp = "".obs;
  String email = '';

  BaseService baseService = BaseService();

  /// Forgot password and verification
  RxBool forgotPassword = false.obs;
  RxBool isVerified = false.obs;

  /// Country selection
  final Rxn<Country> selectedCountry = Rxn<Country>();
  RxString countryCode = "+1".obs;
  RxString flagPath = "packages/country_icons/icons/flags/png100px/us.png".obs;

  final ImagePicker _picker = ImagePicker();
  Rxn<File> profilePicture = Rxn<File>();

  Future<void> pickProfileImage() async {
    try {
      PermissionStatus status = await _requestStoragePermission();

      if (status.isDenied) {
        Utils.showToast("Permission denied", true);
        return;
      }

      if (status.isPermanentlyDenied) {
        Utils.showToast(
          "Permission permanently denied. Please enable it from settings.",
          true,
        );
        await openAppSettings();
        return;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        profilePicture.value = File(pickedFile.path);
      }
    } catch (e) {
      Utils.showToast("Error picking image: $e", true);
    }
  }

  Future<PermissionStatus> _requestStoragePermission() async {
    if (Platform.isIOS) {
      return await Permission.photos.request();
    } else {
      // Android 13+ (API 33+)
      if (await _isAndroid13OrAbove()) {
        return await Permission.photos.request();
      } else {
        // Android 12 and below
        return await Permission.storage.request();
      }
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

  Future<void> requestInitialPermissions() async {
    PermissionStatus status = await _requestStoragePermission();

    if (status.isDenied) {
      Utils.showToast("Permission denied", true);
    }

    if (status.isPermanentlyDenied) {
      Utils.showToast(
        "Permission permanently denied. Enable it from settings.",
        true,
      );
      await openAppSettings();
    }
  }


  /// Text controllers for login
  final TextEditingController loginEmailField = TextEditingController();
  final TextEditingController loginPasswordField = TextEditingController();

  /// Text controllers for signup
  final TextEditingController signupNameField = TextEditingController();
  final TextEditingController signupEmailField = TextEditingController();
  final TextEditingController signupPhoneField = TextEditingController();
  final TextEditingController signupPasswordField = TextEditingController();
  final TextEditingController signupConfirmPasswordField = TextEditingController();


  final TextEditingController editProfileEmail = TextEditingController();



  /// Text controllers for otp
  final TextEditingController otpField = TextEditingController();

  /// Text controllers for fogotVerifyOtp
  final TextEditingController forgotEmailField = TextEditingController();
  final TextEditingController forgotVerifyOtpField = TextEditingController();

  /// Text controllers for forgotPassword
  final TextEditingController forgotNewPassField = TextEditingController();
  final TextEditingController forgotConfirmPassField = TextEditingController();


  /// SharedPreferences storage
  final prefs = SharedPreferencesMethod.storage;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Open country picker
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

  /// SignUp API call
  Future<void> signUp(BuildContext context,{File? profilePicture}) async {
    try {
      final uri = Uri.parse("${BaseService().baseURL}${ApiEndPoints.signupUser}");
      final request = http.MultipartRequest('POST', uri);

      request.fields['fullname'] = signupNameField.text.trim();
      request.fields['email'] = signupEmailField.text.trim();
      request.fields['phone'] = "0";
          // fullPhoneNumber.value;
      request.fields['password'] = signupPasswordField.text.trim();
      request.fields['confirmPassword'] = signupConfirmPasswordField.text.trim();

      if (profilePicture != null && profilePicture.existsSync()) {
        final fileName = profilePicture.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ));
      }

      // ------------------------------
      // PRINT BODY BEFORE HIT
      // ------------------------------
      print(uri);
      print("⏳ SIGNUP API BODY:");
      print("➡ Fields: ${request.fields}");
      print("➡ File: ${profilePicture != null ? profilePicture.path : 'No file attached'}");

      // Optional Auth Header
      final bearerToken = await prefs.getString(LocalDBKeys.TOKEN);
      if (bearerToken != null && bearerToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $bearerToken';
      }

      // Send request
      final streamedResponse =
      await request.send().timeout(const Duration(seconds: 60));

      final responseString = await streamedResponse.stream.bytesToString();
      final responseMap = json.decode(responseString);

      final int statusCode =
          responseMap['statusCode'] ?? streamedResponse.statusCode;
      final bool success = responseMap['success'] ?? false;



      // SUCCESS
      if (success == true && statusCode == 201) {
        Utils.showToast(
            responseMap['message'] ?? "Signup successful", false);

        final data = responseMap['data'];
        print(data);
        print("Status Code: ${statusCode}");


        if (data != null && data['email'] != null) {
          email = data['email'];
        }

        final prefsInstance = await SharedPreferences.getInstance();
        await prefsInstance.setString(
          LocalDBKeys.USERFULLNAME,
          signupNameField.text.trim(),
        );
        successDialog(
          context,
          "Successfully",
          "Your account has been successfully\ncreated.",
          "Login",
              () {
            Get.offNamed("login");
          },);
        // Get.offAllNamed("verification");
        clearSignupFields();
        return;
      }

      // ERRORS
      if (statusCode == 400) {
        Utils.showToast(responseMap['message'] ?? "Bad request", true);
      } else if (statusCode == 404) {
        Utils.showToast(responseMap['message'] ?? "Not found", true);
      } else if (statusCode >= 500) {
        Utils.showToast(
          "Server error: ${responseMap['message'] ?? statusCode}",
          true,
        );
      } else {
        Utils.showToast(
          responseMap['message'] ?? "Signup failed",
          true,
        );
      }

    } on TimeoutException {
      Utils.showToast("Request timed out", true);
    } on SocketException {
      Utils.showToast("No Internet connection", true);
    } catch (e) {
      Utils.showToast("Unexpected error: $e", true);
    }
  }

  Future<void> login() async {
    final body = {
      'email': loginEmailField.text.trim(),
      'password': loginPasswordField.text.trim(),
    };

    try {
      final response = await baseService.basePostAPI(
        ApiEndPoints.loginUser,
        body,
        loading: true,
      );

      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      if (response is! Map<String, dynamic>) {
        Utils.showToast('Unexpected response: ${response.toString()}', true);
        return;
      }

      // Use data key
      final data = response['data'];
      if (data == null) {
        Utils.showToast(response['message'] ?? 'Login failed', true);
        return;
      }

      date.value = response['data']['user']['createdAt'];
      final user = data['user'];
      final token = data['accessToken'];

      if (user == null || token == null) {
        Utils.showToast(response['message'] ?? 'Invalid email or password', true);
        return;
      }

      // Save user info
      final prefs = SharedPreferencesMethod.storage;
      await prefs.setString(LocalDBKeys.USERDETAIL, jsonEncode(user));
      await prefs.setString(LocalDBKeys.USERFULLNAME, user['fullname'] ?? "");
      await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
      await prefs.setString(LocalDBKeys.PHONENUMBER, user['phone'] ?? "");
      await prefs.setString(LocalDBKeys.USERPROFILEPIC, user['profilePicture'] ?? "");
      await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
      await prefs.setString(LocalDBKeys.TOKEN, token);


      print("✅ Token stored successfully: ${prefs.getString(LocalDBKeys.TOKEN)}");
      print("✅ Token stored successfully: ${prefs.getString(LocalDBKeys.USEREMAIL)}");

      Utils.showToast(response['message'] ?? 'Login successful', false);

      // Navigate to bottom bar
      Get.offAllNamed('/bottomnavbar');

      // Clear input fields
      clearLoginFields();
    } catch (e, stackTrace) {
      print("Login error: $e\n$stackTrace");
      Utils.showToast('Something went wrong. Please try again.', true);
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = SharedPreferencesMethod.storage;
    await prefs.clear();
    Get.offAllNamed('/login');
    successDialog(context, "Done!", "You’ve been logged out successfully.", "Ok", (){
      Get.back();
    });

  }

  var resendSeconds = 80.obs;
  var canResend = false.obs;
  Timer? _timer;

  void startResendTimer() {
    canResend.value = false;       // Disable resend
    resendSeconds.value = 50;      // Reset timer

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        canResend.value = true;    // Enable resend
        timer.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;      // Prevent spamming

    // Call your API
    await baseService.basePostAPI(
      ApiEndPoints.resendOtp,
      {"email": email},
      loading: true,
    );

    // Restart timer after sending OTP
    startResendTimer();
  }

  Future<void> verifyOtp(BuildContext context,{String? msg}) async {
    final body = {
      'email': email,
      'otp': otp.value,
    };

    print("Forgot password flag = ${forgotPassword.value}");

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.verifyOtp,
        body,
        loading: true,
      );

      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      final int statusCode = response['statusCode'] ?? 0;

      if (statusCode >= 200 && statusCode < 300) {
        Utils.showToast(response['message'] ?? 'OTP Verified Successfully', false);

          if(forgotPassword.value == true){
            Get.offNamed("reset");
            // successDialog(
            //   context,
            //   "Successfully",
            //   "Your password has been successfully\nupdated.",
            //   "Login",
            //       () {
            //     Get.offNamed("login");
            //   },);
          }else{
            successDialog(
              context,
              "Successfully",
              "Your email has been successfully\nverified.",
              "Login",
                  () {
                Get.offNamed("login");
              },);
          }


        signupEmailField.clear();
        otp.value = '';
      }

    } catch (e) {
      Utils.showToast('Something went wrong: $e', true);
    }
  }

  Future<void> forgotEmailVerification(BuildContext context, {bool? isForget}) async {
    final body = {
      'email': forgotEmailField.text.trim(),
    };


    print("Forgot password flag = ${forgotEmailField.text.trim()}");

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.forgotPassword,
        body,
        loading: true,
      );

      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      final int statusCode = response['statusCode'] ?? 0;
      email = response['data']['email'];

      if (statusCode >= 200 && statusCode < 300) {
        Utils.showToast(response['message'] ?? 'OTP sent to your email', false);

          Get.toNamed("verification");
        forgotEmailField.clear();
        //forgotPasswordField.clear();
      }

    } catch (e) {
      Utils.showToast('Something went wrong: $e', true);
    }
  }

  Future<void> forgotVerifyOtp(BuildContext context) async {
    final body = {
      "email": email,
      "otp": otp.value,
    };

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.forgotVerifyOtp,
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
         resetToken = response['data']['resetToken'];
         print(resetToken);
        // Go to Reset Password screen
        Get.toNamed("reset");
        clearForgotVerifyOtpFields();
        return;
      }

      // Error
      Utils.showToast(response['message'] ?? 'Invalid or expired OTP', true);

    } catch (e) {
      Utils.showToast("Error: $e", true);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    final body = {
      "resetToken": resetToken,
      "newPassword": forgotNewPassField.text.trim(),
      "confirmPassword": forgotConfirmPassField.text.trim(),
    };

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.resetPassword,
        body,
        loading: true,
      );

      // Internet issue
      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }
      print(resetToken);
      print(forgotNewPassField.text.trim());
      print(forgotConfirmPassField.text.trim());

      final int statusCode = response['statusCode'] ?? 0;

      // Success Case
      if (statusCode >= 200 && statusCode < 300) {
        Utils.showToast(response['message'] ?? 'Password reset successfully', false);

          successDialog(
            context,
            "Successfully",
            "Your password has been successfully\nupdated.",
            "Login",
                () {
              Get.offNamed("login");
            },);
          clearResetPasswordFields();
          return;
      }

      // Error Case – API returns error message
      Utils.showToast(response['message'] ?? 'Something went wrong', true);

    } catch (e) {
      Utils.showToast("Error: $e", true);
    }
  }



  /// Clear signup fields
  void clearSignupFields() {
    signupNameField.clear();
    signupEmailField.clear();
    fullPhoneNumber.value = '';
    signupPasswordField.clear();
    signupConfirmPasswordField.clear();
    profilePicture.value = null;
  }

  /// Clear login fields
  void clearLoginFields() {
    loginEmailField.clear();
    loginPasswordField.clear();
  }

  void clearForgotVerifyOtpFields(){
    email = '';
    otp.value = '';
  }

  void clearResetPasswordFields(){
    forgotNewPassField.clear();
    forgotConfirmPassField.clear();
  }
}
