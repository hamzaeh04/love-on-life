import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart';
import '../../widgets/custom_text_field.dart';
class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
          customText(
              text: 'Forget Password',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700
          ),SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                  text: 'Sent to yourname@gmail.com',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(width: 3.w),
              customText(
                  text: 'Resend',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: resetBlueColor,
                txtDecoration: TextDecoration.underline,
                  height: 0.1.h
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                  text: 'Want to this Email Address',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(width: 3.w),
              customText(
                  text: 'Update',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: resetBlueColor,
                  txtDecoration: TextDecoration.underline,
                height: 0.1.h
              ),
            ],
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 3.5.h),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: textfieldBorderColor,
                  enabledBorderColor: textfieldBorderColor,
                  focusedBorderColor: textfieldBorderColor,
                  borderWidth: 0.5, // 👈 slim border
                  borderRadius: BorderRadius.circular(50.sp),
                  fieldWidth: 50,
                  fieldHeight: 50,
                  showFieldAsBox: true, // box style
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    print("OTP: $verificationCode");
                  },
                ),
                SizedBox(height: 4.5.h),

                customButton("Update",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                Get.toNamed("reset");
                }),
                SizedBox(height: 28.h,),
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
