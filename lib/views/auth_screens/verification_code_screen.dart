import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/utility.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  final AuthController timerController = Get.find<AuthController>()..startResendTimer();
  GlobalKey<FormState> verificationKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: verificationKey,
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
              Obx(() => customText(
                text: controller.forgotPassword.value == true
                    ? 'Verification Code'
                    : 'OTP Verification',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              )),
              SizedBox(height: 1.h),
              Obx(() => customText(
                text: controller.forgotPassword.value == true
                    ? 'An email has been sent to you with a verification\ncode. Please enter it here.'
                    : 'Please enter the 6-digit OTP sent to your\nregistered email address to verify your account.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: loginGreyColor,
                textAlign: TextAlign.center,
              )),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w,),
                        Center(
                          child: OtpTextField(
                            numberOfFields: 6,
                            borderColor: textfieldBorderColor,
                            enabledBorderColor: textfieldBorderColor,
                            focusedBorderColor: textfieldBorderColor,
                            borderWidth: 0.5,
                            borderRadius: BorderRadius.circular(50.sp),
                            fieldWidth: 12.w,
                            fieldHeight: 6.h,
                            filled: true,
                            fillColor: whiteColor,
                            showFieldAsBox: true,

                            keyboardType: TextInputType.number, // 👈 numeric keyboard

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly, // 👈 ONLY NUMBERS
                            ],

                            textStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                            contentPadding: EdgeInsets.zero,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            onCodeChanged: (String code) {},

                            onSubmit: (String verificationCode) {
                              controller.otp.value = verificationCode;
                              print("OTP: $verificationCode");
                            },
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => customText(
                          text: controller.canResend.value
                              ? "You can resend now"
                              : "Resending in 00:${controller.resendSeconds.value.toString().padLeft(2, '0')}",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: loginGreyColor,
                        )),
                        Obx(() => InkWell(
                          onTap: controller.canResend.value
                              ? () => controller.resendOtp()
                              : null,
                          child: customText(
                            text: "Resend Code",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: controller.canResend.value
                                ? buttonPinkColor
                                : loginGreyColor,
                            txtDecoration: TextDecoration.underline,
                            decorationColor: controller.canResend.value
                                ? buttonPinkColor
                                : loginGreyColor,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Obx(() => customButton(
                      controller.forgotPassword.value == true ? "Continue" : "Verify",
                      color: buttonPinkColor,
                      fontweight: FontWeight.w700,
                      fontsize: 16.sp,
                      textColor: whiteColor,
                      ontap: () {
                        if(controller.otp.value.length == 6){
                          if (controller.forgotPassword.value == true) {
                            controller.forgotVerifyOtp(context);
                          } else {
                            controller.verifyOtp(context);
                          }
                        }else{
                          Utils.showToast('Please fill all the fields', true);
                        }
                      },
                    )),
                    SizedBox(height: 26.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, size: 18.5.sp),
                            SizedBox(width: 3.w),
                            customText(
                              text: 'Back',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}
