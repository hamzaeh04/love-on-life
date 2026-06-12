import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/core/services/login/apple_auth_service.dart';
import 'package:love_on_life/core/services/login/google_auth_service.dart';
import 'package:love_on_life/utils/helper_functions.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:love_on_life/widgets/social_icon_widget.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();
  final GoogleAuthService _authService = GoogleAuthService();
  final AppleAuthService _appleAuthService = AppleAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // fix keyboard overflow
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              Center(
                child: Image.asset(
                  'assets/png/auth_logo.png',
                  width: 50.w,
                ),
              ),
              customText(
                text: 'Login',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              customText(
                text: 'Enter your credentials to Sign In',
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: loginGreyColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 2.5.h),
                    customTextFeild(
                      controller: controller.loginEmailField,
                      'Email Address',
                      'yourname@gmail.com',
                      'assets/png/email_logo.png',
                      false,
                      isRequired: true,
                      validator: (value) => HelperFunction.emailValidate(value),
                    ),
                    SizedBox(height: 1.h),
                    Obx(() => customTextFeild(
                        controller: controller.loginPasswordField,
                        'Password',
                        '•••••••••••',
                        'assets/png/lock.png',
                        true,
                        isRequired: true,
                        obscureText: controller.isPasswordVisible.value,
                        icon: controller.isPasswordVisible.value == false? Icon(Icons.visibility_outlined, size: 18.sp,): Icon(Icons.visibility_off_outlined, size: 18.sp,),
                        ontap: (){
                          controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                        },
                        validator: (value) => HelperFunction.passwordValidate(value),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            customCheckBox(
                              initialValue: false,
                              onChanged: (value) {
                                print("Checkbox state: $value");
                              },
                            ),
                            SizedBox(width: 2.w),
                            customText(
                              text: 'Remember Me',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: loginGreyColor,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            controller.forgotPassword.value = true;
                            Get.toNamed('forgot');
                          },
                          child: customText(
                            text: 'Forgot password?',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: buttonPinkColor,
                            txtDecoration: TextDecoration.underline,
                            decorationColor: buttonPinkColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    customButton(
                      "Sign In",
                      color: buttonPinkColor,
                      fontweight: FontWeight.w700,
                      fontsize: 16.sp,
                      textColor: whiteColor,
                      ontap: () {
                        if (loginKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Divider(
                              color: textfieldBorderColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        customText(
                          text: 'or',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Divider(
                              color: textfieldBorderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Platform.isAndroid
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            socialIconWidget(
                                                  "assets/png/social_icons/google.png",
                                                  ontap: () async {
                            var user = await _authService.login();

                            if (user != null) {
                              controller.googleLogin(_authService);
                            }
                                                  },
                                                ),
                          ],
                        )
                        : Platform.isIOS
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialIconWidget(
                          "assets/png/social_icons/google.png",
                          ontap: () async {
                            var user = await _authService.login();

                            if (user != null) {
                              controller.googleLogin(_authService);
                            }
                          },
                        ),

                        SizedBox(width: 4.w),

                        socialIconWidget(
                          "assets/png/social_icons/apple.png",
                          ontap: () async {
                            await _appleAuthService.signInWithApple();
                          },
                        ),
                      ],
                    )
                        : const SizedBox(),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customCheckBox(
                          initialValue: true,
                          onChanged: (value) {
                            print("Checkbox state: $value");
                          },
                        ),
                        SizedBox(width: 2.w),
                        customText(
                          text: "By Signing Up you agree to our",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4,
                        ),
                        SizedBox(width: 1.w),
                        InkWell(
                          onTap: (){
                            controller.openTerms();
                          },
                          child: customText(
                            text: "Terms",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            txtDecoration: TextDecoration.underline,
                            height: 0.1.h,
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        customText(
                          text: "&",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(width: 1.w),
                        InkWell(
                          onTap: (){
                            controller.openPrivacyPolicy();
                          },
                          child: customText(
                            text: "Privacy Policy.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            txtDecoration: TextDecoration.underline,
                            height: 0.1.h,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: "Don't have an account?",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4,
                        ),
                        SizedBox(width: 0.5.w),
                        InkWell(
                          onTap: () {
                            Get.toNamed("signup");
                          },
                          child: customText(
                            text: "Sign Up",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            txtDecoration: TextDecoration.underline,
                            height: 0.1.h,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customCheckBox({
  bool initialValue = false,
  Function(bool)? onChanged,
}) {
  RxBool isChecked = initialValue.obs;

  return Obx(
        () => GestureDetector(
      onTap: () {
        isChecked.value = !isChecked.value;
        if (onChanged != null) onChanged(isChecked.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 2.h,
        width: 4.2.w,
        decoration: BoxDecoration(
          color: isChecked.value ? buttonPinkColor : whiteColor,
          border: Border.all(
            color: isChecked.value ? buttonPinkColor : textfieldBorderColor,
            width: 0.2.w,
          ),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: isChecked.value
            ? Icon(
          Icons.check,
          color: whiteColor,
          size: 16.sp,
        )
            : null,
      ),
    ),
  );
}
