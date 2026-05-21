import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/utils/helper_functions.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart';
import '../../core/services/login/apple_auth_service.dart';
import '../../core/services/login/google_auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/social_icon_widget.dart';
import 'login_screen.dart';
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  final GoogleAuthService _authService = GoogleAuthService();
  final AppleAuthService _appleAuthService = AppleAuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: signupKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h,),
              Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
              customText(
                  text: 'Sign Up',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700
              ),
              customText(
                  text: 'Enter your credentials to create your account.',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(height: 3.h),
              Obx(
                    () => GestureDetector(
                  onTap: () async {
                    await controller.pickProfileImage();
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Profile Image
                      Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: controller.profilePicture.value != null
                                ? FileImage(controller.profilePicture.value!) as ImageProvider
                                : const AssetImage("assets/png/profile_img.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Camera Icon
                      Positioned(
                        right: 2.w,
                        bottom: -0.5.h,
                        child: Container(
                          width: 7.w,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: Image.asset(
                              "assets/png/camera_img.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Padding(
                padding:EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(height: 2.5.h,),
                    customTextFeild(
                        controller: controller.signupNameField,
                        validator: (value) => HelperFunction.stringValidate(value),
                        'Full Name', 'Enter full name', 'assets/png/person.png', false,isRequired: true),
                    SizedBox(height: 1.5.h,),
                    customTextFeild(
                        controller: controller.signupEmailField,
                        validator: (value) => HelperFunction.emailValidate(value),
                        'Email Address', 'yourname@gmail.com', 'assets/png/lock.png', false,isRequired: true),

                    SizedBox(height: 1.5.h,),
                    Obx(() => customTextFeild(
                        validator: (value) => HelperFunction.passwordValidate(value),
                        controller: controller.signupPasswordField,
                        'New Password',
                        '•••••••••••',
                        'assets/png/lock.png',
                        true,
                        isRequired: true,
                        obscureText: controller.isPasswordVisible.value,
                        icon: controller.isPasswordVisible.value == false? Icon(Icons.visibility_outlined, size: 18.sp,): Icon(Icons.visibility_off_outlined, size: 18.sp,),
                        ontap: (){
                          controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                        },
                      ),
                    ),
                    SizedBox(height: 1.5.h,),
                    Obx(() =>
                       customTextFeild(
                        validator: (value) => HelperFunction.passwordValidate(value),
                        controller: controller.signupConfirmPasswordField,
                        'Confirm Password',
                        '•••••••••••',
                        'assets/png/lock.png',
                        true,
                        isRequired: true,
                        obscureText: controller.isPasswordVisibleConfirm.value,
                        icon: controller.isPasswordVisibleConfirm.value == false? Icon(Icons.visibility_outlined, size: 18.sp,): Icon(Icons.visibility_off_outlined, size: 18.sp,),
                        ontap: (){
                          controller.isPasswordVisibleConfirm.value = !controller.isPasswordVisibleConfirm.value;
                        },
                      ),
                    ),
                    SizedBox(height: 3.5.h),
                    customButton("Sign Up",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,
                        ontap: (){
                      if(signupKey.currentState!.validate()){
                        controller.signUp(context, profilePicture: controller.profilePicture.value);
                      }

                      print(controller.signupNameField.text);
                      print(controller.signupEmailField.text);
                      print(controller.fullPhoneNumber.value);
                      print(controller.signupPasswordField.text);
                      print(controller.signupConfirmPasswordField.text);
                      print(controller.profilePicture.value);

                    }),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Expanded(child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Divider(
                            color: textfieldBorderColor,
                          ),
                        )),
                        SizedBox(width: 4.w),
                        customText(
                          text: 'or',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Divider(
                            color: textfieldBorderColor,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Platform.isAndroid
                        ? socialIconWidget(
                      "assets/png/social_icons/google.png",
                      ontap: () async {
                        var user = await _authService.login();

                        if (user != null) {
                          controller.googleLogin(_authService);
                        }
                      },
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
                          onTap: (){
                            Get.toNamed("login");
                          },
                          child: customText(
                            text: "Sign In",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            txtDecoration: TextDecoration.underline,
                            height: 0.1.h,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
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

