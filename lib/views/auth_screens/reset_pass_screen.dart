import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart';
import '../../widgets/custom_text_field.dart';
class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
          customText(
              text: 'Reset Password',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700
          ),
          SizedBox(height: 1.h),
          customText(
              text: 'Type in a new password',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: loginGreyColor
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2.5.h,),
                customTextFeild(
                  'New Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true, // 👈 password field, eye button aa jayega
                ),
                SizedBox(height: 1.h,),
                customTextFeild(
                  'Retype New Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true, // 👈 password field, eye button aa jayega
                ),
                SizedBox(height: 3.5.h),
                customButton("Continue",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){

                }),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,size: 18.5.sp),
                        SizedBox(width: 3.w),
                        customText(
                          text: 'Back',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
