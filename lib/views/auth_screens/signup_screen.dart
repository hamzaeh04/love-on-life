import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/custom_phone_feild.dart';
import 'package:love_on_life/widgets/success_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/social_icon_widget.dart';
import 'login_screen.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            Stack(
              clipBehavior: Clip.none,
              children: [
              Image.asset("assets/png/profile_img.png",width: 25.w),
              Positioned(
                right: 4.2.w,
                bottom: -0.5.h,
                  child: Image.asset("assets/png/camera_img.png",width: 7.w)
              )
            ],
        
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(height: 2.5.h,),
                  customTextFeild('Full Name', 'Enter full name', 'assets/png/person.png', false,isRequired: true),
                  SizedBox(height: 1.5.h,),
                  customTextFeild('Email Address', 'yourname@gmail.com', 'assets/png/lock.png', false,isRequired: true),
                  SizedBox(height: 1.5.h,),
                  CustomPhoneTextFeild(),
                  SizedBox(height: 1.5.h,),
                  customTextFeild(
                    'New Password',
                    '•••••••••••',
                    'assets/png/lock.png',
                    true, // 👈 password field, eye button aa jayega
                    isRequired: true,
                  ),
                  SizedBox(height: 1.5.h,),
                  customTextFeild(
                    'Confirm Password',
                    '•••••••••••',
                    'assets/png/lock.png',
                    true, // 👈 password field, eye button aa jayega
                    isRequired: true,
                  ),
                  SizedBox(height: 3.5.h),
                  customButton("Sign Up",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                    Get.toNamed("verification");
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                          },
                          child: socialIconWidget("assets/png/social_icons/google.png")),
                      InkWell(
                          onTap: (){
                          },
                          child: socialIconWidget("assets/png/social_icons/apple.png")),
                      InkWell(
                          onTap: (){
                          },
                          child: socialIconWidget("assets/png/social_icons/facebook_logo.png")),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customCheckBox(
                        initialValue: false,
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
                      customText(
                        text: "Terms",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        txtDecoration: TextDecoration.underline,
                        height: 0.1.h,
                        letterSpacing: -0.4,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: "&",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: "Privacy Policy.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        txtDecoration: TextDecoration.underline,
                        height: 0.1.h,
                        letterSpacing: -0.4,

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
    );
  }
}

// Widget phoneNumberField() {
//   final LoginController controller = Get.find<LoginController>();
//
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 4.w),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(25.sp),
//       border: Border.all(
//         color: textfieldBorderColor,
//         width: 0.8,
//       ),
//     ),
//     child: Row(
//       children: [
//
//         /// ✅ Country Flag (Selectable)
//         GestureDetector(
//           onTap: () {
//             showCountryPicker(
//               context: Get.context!,
//               showPhoneCode: true,
//               onSelect: (country) {
//                 controller.countryCode.value = "+${country.phoneCode}";
//                 controller.countryName.value = country.name;
//
//                 /// ✅ FIX: USE REAL FLAG ASSET FROM PACKAGE
//                 controller.flagPath.value =
//                 "packages/country_picker/assets/flags/${country.countryCode.toLowerCase()}.png";
//
//               },
//             );
//           },
//           child: Obx(() => ClipOval(
//             child: Image.asset(
//               controller.flagPath.value,
//               package: 'country_picker',
//               width: 4.7.h,
//               height: 4.7.h,
//               fit: BoxFit.cover,
//             ),
//           )),
//         ),
//
//         SizedBox(width: 2.w),
//
//         /// ✅ Country Code
//         Obx(() => customText(
//           text: controller.countryCode.value,
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w400,
//           color: loginGreyColor,
//         )),
//
//         SizedBox(width: 1.w),
//
//         Icon(Icons.keyboard_arrow_down_outlined,
//             size: 20.sp, color: loginGreyColor),
//
//         SizedBox(width: 3.w),
//
//         Expanded(
//           child: TextField(
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Enter your phone number",
//               hintStyle: TextStyle(
//                 fontFamily: 'dmsans',
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14.sp,
//                 color: loginGreyColor,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

