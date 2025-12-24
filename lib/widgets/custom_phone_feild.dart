import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../controllers/auth_controller.dart';

class CustomPhoneTextFeild extends StatelessWidget {
  final TextEditingController? controller;

  CustomPhoneTextFeild({this.controller, super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                /// 🇵🇰 Flag
                GestureDetector(
                  onTap: () => authController.openPicker(context),
                  child: ClipOval(
                    child: Image.asset(
                      authController.flagPath.value,
                      width: 4.h,
                      height: 4.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 2.w),

                /// +92 ▼ Country Code
                GestureDetector(
                  onTap: () => authController.openPicker(context),
                  child: Row(
                    children: [
                      Obx(
                            () => customText(
                          text: authController.countryCode.value,
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

                /// 📞 Phone Number Input
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black, fontFamily: 'dmsans'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                        fontFamily: 'dmsans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),

                    /// 👇 UPDATE FULL PHONE NUMBER AUTOMATICALLY
                    onChanged: (value) {
                      authController.fullPhoneNumber.value =
                      "${authController.countryCode.value}$value";

                      //print("📞 Final Phone: ${authController.fullPhoneNumber.value}");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
