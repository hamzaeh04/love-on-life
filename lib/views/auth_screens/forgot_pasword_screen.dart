import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/login_contoller.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});
final LoginController controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
          customText(
              text: 'Forgot Password',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700
          ),SizedBox(height: 1.h),
          customText(
              text: 'An email has been sent to you with a verification\ncode. Please enter it here.',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: loginGreyColor,
            textAlign: TextAlign.center
          ),
          SizedBox(height: 1.h),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2.h),
                customTextFeild('Email Address', 'yourname@gmail.com', 'assets/png/email_logo.png', false),
                SizedBox(height: 4.5.h),

                customButton("Continue",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                  controller.forgotPassword.value = true;
                  Get.toNamed("verification");
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
