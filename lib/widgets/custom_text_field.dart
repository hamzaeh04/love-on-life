import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/login_contoller.dart'; // 👈 apna controller import karo

Widget customTextFeild(
    String title,
    String hintText,
    String path,
    bool isPass,
    ) {
  final loginController = Get.put(LoginController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 6.w),
        child: customText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: loginGreyColor,
        ),
      ),
      SizedBox(height: 0.5.h),
      isPass
          ? Obx(
            () => TextField(
          obscureText: loginController.isPasswordVisible.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 1.8.h),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(
                color: textfieldBorderColor, // 👈 custom border color
                width: 0.8,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(
                color: textfieldBorderColor, // 👈 custom border color
                width: 1.2,
              ),
            ),

            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 6.w),
                Image.asset(path, height: 5.w, fit: BoxFit.contain),
                SizedBox(width: 4.w),
              ],
            ),

            prefixIconConstraints: BoxConstraints(
              minWidth: 2.w,
              minHeight: 2.h,
            ),

            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'dmsans',
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),

            suffixIcon: IconButton(
              icon: Image.asset(
                loginController.isPasswordVisible.value
                    ? "assets/png/eye-off.png"
                    : "assets/png/eye.png",
                height: 5.w,
                fit: BoxFit.contain,
              ),
              onPressed: loginController.togglePasswordVisibility,
            ),
          ),
        ),
      )
          : TextField(
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 1.8.h),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              color: textfieldBorderColor, // 👈 custom border color
              width: 0.8,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              color: textfieldBorderColor, // 👈 custom border color
              width: 1.2,
            ),
          ),

          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 6.w), // left side gap from border
              Image.asset(path, height: 5.w, fit: BoxFit.contain),
              SizedBox(width: 4.w), // icon aur hint text ke beech gap
            ],
          ),

          prefixIconConstraints: BoxConstraints(
            minWidth: 2.w,
            minHeight: 2.h,
          ),

          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'dmsans',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
      ),
    ],
  );
}
