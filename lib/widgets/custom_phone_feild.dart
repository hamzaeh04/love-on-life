import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../controllers/auth_controller.dart';

class CustomPhoneTextFeild extends StatelessWidget {
  CustomPhoneTextFeild({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Row(
                  children: [
                    customText(
                      text: "Phone No",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                    customText(
                      text: "*",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: redColor,
                    )
                  ],
                ),
              ),
              Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.2.h),
                      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.sp),
              border: Border.all(
                color: textfieldBorderColor,
                width: 0.8,
              ),
                      ),
                      child: Row(
              children: [
                /// ✅ Circular Flag Image
                GestureDetector(
                  onTap: () => controller.openPicker(context),
                  child: ClipOval(
                    child: Image.asset(
                      controller.flagPath.value,
                      width: 4.h,
                      height: 4.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),

                /// ✅ Country Code + Dropdown Arrow
                GestureDetector(
                  onTap: () => controller.openPicker(context),
                  child: Row(
                    children: [
                      Obx(
                            () => customText(
                          text: controller.countryCode.value,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: loginGreyColor,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 20.sp,
                        color: loginGreyColor,
                      ),
                    ],
                  ),
                ),


                SizedBox(width: 3.w),

                /// ✅ Phone TextField
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,         // ✅ removes default border
                      enabledBorder: InputBorder.none,  // ✅ removes grey border
                      focusedBorder: InputBorder.none,  // ✅ removes blue border on focus
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                        fontFamily: 'dmsans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                      contentPadding: EdgeInsets.zero, // optional: remove extra padding
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
