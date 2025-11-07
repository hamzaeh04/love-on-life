import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/success_dialog.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/login_contoller.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({
    super.key,
  });
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
          Obx(() =>
            customText(
                text: controller.forgotPassword.value == true ? 'Verification Code':'OTP Verification',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700
            ),
          ),SizedBox(height: 1.h),
          Obx(() =>
            customText(
                text: controller.forgotPassword.value == true ? 'An email has been sent to you with a verification\ncode. Please enter it here.':'Please enter the 6-digit OTP sent to your\nregistered email address to verify your account.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: loginGreyColor,
              textAlign: TextAlign.center
            ),
          ),
          SizedBox(height: 1.h),
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
                borderWidth: 0.5,
                borderRadius: BorderRadius.circular(50.sp),
                fieldWidth: 50,
                fieldHeight: 50,
                filled: true,
                fillColor: whiteColor,
                showFieldAsBox: true,

                // ✅ This centers the numbers vertically & horizontally
                textStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  height: 1, // 🔥 Important: controls vertical alignment
                ),

                // ✅ Force proper vertical alignment inside field
                contentPadding: EdgeInsets.zero,

                // ✅ Makes spacing equal on all devices
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  print("OTP: $verificationCode");
                },
              ),


                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                        text: 'Resending in 00:50',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: loginGreyColor
                    ),
                    InkWell(
                      onTap: (){
                      },
                      child: customText(
                          text: 'Resend Code',
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

                Obx(() =>
                  customButton(controller.forgotPassword.value == true ? "Continue":"Verify",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){

                    if(controller.forgotPassword.value == true){
                    Get.toNamed("reset");
                    }
                    else{
                      successDialog(context, "Successfully", "Your email has been successfully\nverified.","Login",(){
                        Get.offNamed("login");
                      });
                    }

                  }),
                ),
                SizedBox(height: 26.5.h,),
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
