import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset("assets/png/profile.png",width: 30.w),
                  Positioned(
                      right: 5.w,
                      bottom: 0.h,
                      child: Image.asset("assets/png/camera_img.png",width: 7.w)
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              customText(
                  text: 'First Name',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                height: 0.15.h
              ),
              customText(
                  text: 'Tom Albert',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(height: 2.h),
              customText(
                  text: 'Email Address',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                  height: 0.15.h
              ),
              customText(
                  text: 'tomalbert@gmail.com',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(height: 2.h),
              customText(
                  text: 'Contact Number',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                  height: 0.15.h
              ),
              customText(
                  text: '+19159969739',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: loginGreyColor
              ),
              SizedBox(height: 5.h),
              customButton("Edit Profile",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                Get.toNamed("edit");
              }),
              SizedBox(height: 1.5.h),
              customButton("Change Password",color: backgroundColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: buttonPinkColor,borderColor: buttonPinkColor,ontap: (){
                Get.toNamed("change");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
