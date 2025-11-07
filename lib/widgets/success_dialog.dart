import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'custom_button.dart';

void successDialog(BuildContext context,String title, String description,String buttonText,VoidCallback ontap,{bool? isLogout = false,VoidCallback? ontap2,String? buttonText2}) {
  showDialog(
    context: context,
    // barrierDismissible: true,
    barrierColor: Colors.grey.withOpacity(0.1), // dim background slightly
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // ✅ Blur Effect
        child: Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Stack(
            children: [

              /// Main Dialog UI
              Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 2.h),

                    /// ✅ Green Tick Icon
                    SizedBox(
                      height: 7.h,
                      width: 7.h,
                      child: isLogout == false ? Image.asset("assets/png/dialog_icon.png"): Image.asset('assets/png/oops.png'),
                    ),
                    SizedBox(height: 1.h),

                    /// ✅ Title
                    customText(
                      text: title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 1.h),

                    /// ✅ Subtitle
                    customText(
                      text: description,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: loginGreyColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),

                    /// ✅ OK Button
                    isLogout == false ?
                    customButton(
                      buttonText,
                      color: buttonPinkColor,
                      fontweight: FontWeight.w700,
                      height: 5.5.h,
                      fontsize: 16.sp,
                      textColor: whiteColor,
                      ontap: ontap
                    ):
                        Row(
                          children: [
                            Expanded(
                              child: customButton(
                                  buttonText,
                                  color: whiteColor,
                                  fontweight: FontWeight.w700,
                                  height: 5.5.h,
                                  fontsize: 16.sp,
                                  textColor: buttonPinkColor,
                                  ontap: ontap,
                                borderColor: buttonPinkColor
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Expanded(
                              child: customButton(
                                  buttonText2!,
                                  color: buttonPinkColor,
                                  fontweight: FontWeight.w700,
                                  height: 5.5.h,
                                  fontsize: 16.sp,
                                  textColor: whiteColor,
                                  ontap: ontap2
                              ),
                            )
                          ],
                        )
                  ],
                ),
              ),

              /// ❌ Close Icon (Top Right)
              Positioned(
                right: 2.w,
                top: 1.5.h,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 3.h,
                    width: 3.h,
                    child: Image.asset(
                      "assets/png/close_icon.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
