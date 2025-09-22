
import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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


              ],
            ),
          ),

        ],
      ),
    );
  }
}
