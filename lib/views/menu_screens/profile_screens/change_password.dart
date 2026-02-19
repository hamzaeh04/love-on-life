import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../controllers/drawer_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_text_field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final Drawercontroller drawerController = Get.find<Drawercontroller>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 👈 important
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("Change Password", padding: 18.w),
              SizedBox(height: 4.h),

              /// Old Password
              Obx(
                    () => customTextFeild(
                  controller: drawerController.oldPassField,
                  'Old Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true,
                  isRequired: true,
                  obscureText: authController.isPasswordVisible.value,
                  icon: Icon(
                    !authController.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18.sp,
                  ),
                  ontap: authController.togglePasswordVisibility,
                ),
              ),

              SizedBox(height: 1.h),

              /// New Password
              Obx(
                    () => customTextFeild(
                  controller: drawerController.newPassField,
                  'New Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true,
                  isRequired: true,
                  obscureText: authController.isPasswordVisibleNew.value,
                  icon: Icon(
                    !authController.isPasswordVisibleNew.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18.sp,
                  ),
                  ontap: () {
                    authController.isPasswordVisibleNew.value =
                    !authController.isPasswordVisibleNew.value;
                  },
                ),
              ),

              SizedBox(height: 1.h),

              /// Confirm Password
              Obx(
                    () => customTextFeild(
                  controller: drawerController.confirmPassField,
                  'Confirm Password',
                  '•••••••••••',
                  'assets/png/lock.png',
                  true,
                  isRequired: true,
                  obscureText:
                  authController.isPasswordVisibleConfirm.value,
                  icon: Icon(
                    !authController.isPasswordVisibleConfirm.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18.sp,
                  ),
                  ontap: () {
                    authController.isPasswordVisibleConfirm.value =
                    !authController.isPasswordVisibleConfirm.value;
                  },
                ),
              ),

              SizedBox(height: 3.5.h),

              customButton(
                "Update",
                color: buttonPinkColor,
                fontweight: FontWeight.w700,
                fontsize: 16.sp,
                textColor: whiteColor,
                ontap: () {
                  drawerController.changePassword(context);
                },
              ),

              SizedBox(height: 2.h), // 👈 extra bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
