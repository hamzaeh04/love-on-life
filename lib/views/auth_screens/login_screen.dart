
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:love_on_life/widgets/social_icon_widget.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';

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
                customTextFeild('Email Address', 'yourname@gmail.com', 'assets/png/person.png', false),
                SizedBox(height: 1.h,),
                customTextFeild(
                  'Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true, // 👈 password field, eye button aa jayega
                ),
                SizedBox(height: 1.h),
                InkWell(
                  onTap: (){
                    Get.toNamed('forgot');
                  },
                  child: customText(
                      text: 'Forgot password?',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    txtDecoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 2.h),
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
                    InkWell(
                      onTap: (){
                        Get.toNamed('profile');
                      },
                        child: socialIconWidget("assets/png/socail_icon/google.png")),
                    SizedBox(width: 4.w),
                    InkWell(
                        onTap: (){
                          Get.toNamed('community');
                        },
                        child: socialIconWidget("assets/png/socail_icon/apple.png"))
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      text: "Already Have a Account?",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                    SizedBox(width: 0.5.w),
                    customText(
                        text: "Sign In",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        txtDecoration: TextDecoration.underline,
                      height: 0.1.h,
                      letterSpacing: -0.4,
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
