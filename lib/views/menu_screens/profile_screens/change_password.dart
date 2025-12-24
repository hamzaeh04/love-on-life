import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../controllers/drawer_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_phone_feild.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/success_dialog.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final Drawercontroller drawerController = Get.find<Drawercontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customHeader("Change Password",padding: 18.w),
            SizedBox(height: 4.h),
            customTextFeild(
              controller: drawerController.oldPassField,
              'Old Password',
              '•••••••••••',
              'assets/png/lock.png',
              true, // 👈 password field, eye button aa jayega
              isRequired: true,
            ),
            SizedBox(height: 1.h,),
            customTextFeild(
              controller: drawerController.newPassField,
              'New Password',
              '•••••••••••',
              'assets/png/lock.png',
              true, // 👈 password field, eye button aa jayega
              isRequired: true,
            ),
            SizedBox(height: 1.h,),
            customTextFeild(
              controller: drawerController.confirmPassField,
              'Confirm Password',
              '•••••••••••',
              'assets/png/lock.png',
              true, // 👈 password field, eye button aa jayega
              isRequired: true,
            ),
            SizedBox(height: 3.5.h),
            customButton("Update",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
              drawerController.changePassword(context);
            }),
          ],
        ),
      ),
    );
  }
}
