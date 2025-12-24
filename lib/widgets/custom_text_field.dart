import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/auth_controller.dart'; // 👈 apna controller import karo

Widget customTextFeild(
    String title,
    String hintText,
    String path,
    bool isPass,
{bool? isRequired, TextEditingController? controller, bool? readOnly,dynamic validator}
    ) {
  final authController = Get.find<AuthController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: Row(
          children: [
            customText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
            isRequired == true ?
            customText(
              text: "*",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: redColor,
            ):
                SizedBox.shrink(),
          ],
        ),
      ),
      SizedBox(height: 0.5.h),
      isPass
          ? Obx(
            () => TextFormField(
              readOnly: readOnly ?? false,
              controller: controller,
          validator: validator,
          obscureText: authController.isPasswordVisible.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 1.7.h),

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
                SizedBox(width: 2.w),
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
              icon: authController.isPasswordVisible.value ? Image.asset('assets/png/eye-off.png', width: 5.5.w,): Icon(Icons.remove_red_eye_outlined, size: 19.sp,),
              onPressed: authController.togglePasswordVisibility,
            ),
          ),
        ),
      )
          : TextFormField(
        validator: validator,
        readOnly: readOnly ?? false,
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 1.7.h),

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
              SizedBox(width: 2.w), // icon aur hint text ke beech gap
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
Widget defaultTextFeild(
    String title,
    String hintText, {
      bool? isRequired,
      bool? istitle = true,
      bool? isSuffix = false,
      bool? isDropDown = false,
      bool? isDate = false,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ✅ Show title only if istitle = true
      istitle == true
          ? Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: Row(
          children: [
            customText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
            isRequired == true
                ? customText(
              text: "*",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: redColor,
            )
                : const SizedBox.shrink(),
          ],
        ),
      )
          : SizedBox(height: 1.7.h),

      istitle == true ? SizedBox(height: 0.5.h) : SizedBox(height: 0.8.h),

      TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          contentPadding: EdgeInsets.symmetric(
            vertical: 1.5.h,
            horizontal: 4.w,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              color: textfieldBorderColor,
              width: 0.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              color: textfieldBorderColor,
              width: 1.2,
            ),
          ),
          prefixIcon: isDate == true ? IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/png/date.png",
              width: 4.w,
              //height: .w,
              fit: BoxFit.contain,
            ),
          )
              : null,

          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'dmsans',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),

          // ✅ Show suffix only if isSuffix = true
          suffixIcon: isSuffix == true
              ? IconButton(
            onPressed: () {},
            icon: Image.asset(
              isDropDown == false ? "assets/png/question_mark.png" : "assets/png/dropdown.png",
              width: isDropDown == false ? 5.w : 3.w,
              height: 5.w,
              fit: BoxFit.contain,
            ),
          )
              : null,
        ),
      ),
    ],
  );
}
