
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/views/dashboard_screens/notification_screen.dart';
import 'package:love_on_life/views/dashboard_screens/profile_screen.dart';
import 'package:love_on_life/views/menu_screens/privacy_policy.dart';
import 'package:love_on_life/views/menu_screens/profile_screens/my_profile.dart';
import 'package:love_on_life/views/payment_method_screens/select_card_screen.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:love_on_life/widgets/social_icon_widget.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';
import '../menu_screens/faq_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
          customText(
            text: 'Login',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700
          ),customText(
            text: 'Enter your credentials to Sign In',
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: loginGreyColor
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2.5.h,),
                customTextFeild('Email Address', 'yourname@gmail.com', 'assets/png/email_logo.png', false,isRequired: true),
                SizedBox(height: 1.h,),
                customTextFeild(
                  'Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true, // 👈 password field, eye button aa jayega
                    isRequired: true
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        checkBox(isChecked: false),
                        SizedBox(width: 2.w),
                        customText(
                            text: 'Remember Me',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: loginGreyColor
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Get.toNamed('forgot');
                      },
                      child: customText(
                          text: 'Forgot password?',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        color: buttonPinkColor,
                        txtDecoration: TextDecoration.underline,
                        decorationColor: buttonPinkColor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                customButton("Sign In",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                Get.toNamed("bottomnavbar");
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
                    socialIconWidget("assets/png/social_icons/google.png",
                      ontap: (){
                      Get.to(SelectCardScreen());
                      }

                    ),
              socialIconWidget(
                "assets/png/social_icons/apple.png",
                ontap: () {
                  Get.to(MyProfile());
                },
              ),

              socialIconWidget("assets/png/social_icons/facebook_logo.png",ontap: (){
                Get.to(NotificationScreen());
              })
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    checkBox(isChecked: false),
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
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
Widget checkBox({bool? isChecked}){
  return Container(
    height: 2.h,
    width: 4.3.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: textfieldBorderColor,
        width: 0.2.w,
      ),
      borderRadius: BorderRadius.circular(8.sp),
      color: whiteColor
    ),
    child: isChecked == true ?
    Icon(Icons.check):
    SizedBox.shrink(),
  );
}
