import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/utils/helper_functions.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_text_field.dart';
class ResetPassScreen extends StatelessWidget {
  ResetPassScreen({super.key});
  AuthController controller = Get.find<AuthController>();
  GlobalKey<FormState> resetKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: resetKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h,),
              Center(child: Image.asset('assets/png/auth_logo.png', width: 50.w,)),
              customText(
                  text: 'Reset Password',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700
              ),
              customText(
                  text: 'Set a new password for your account',
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
                      controller: controller.forgotNewPassField,
                      'New Password',
                      '•••••••••••',
                      'assets/png/lock.png',
                      true,
                      isRequired: true,
                      validator: (value) => HelperFunction.passwordValidate(value),
                    ),
                    SizedBox(height: 1.h,),
                    customTextFeild(
                      controller: controller.forgotConfirmPassField,
                      'Confirm Password',
                      '•••••••••••',
                      'assets/png/lock.png',
                      true,
                      isRequired: true,
                      validator: (value) => HelperFunction.passwordValidate(value),
                    ),
                    SizedBox(height: 3.5.h),
                    customButton("Update",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                      if(resetKey.currentState!.validate()){
                        controller.forgotPassword.value = false;
                        controller.resetPassword(context);
                      }
                    }),
                    SizedBox(height: 22.8.h,),
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
        ),
      ),
    );
  }
}
