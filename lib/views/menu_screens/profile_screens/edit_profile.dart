import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_phone_feild.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/success_dialog.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customHeader("Edit Profile"),
            SizedBox(height: 4.h),
            Center(
              child: Stack(
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
            ),
            SizedBox(height: 2.5.h,),
            customTextFeild('Full Name', 'Tom Albert', 'assets/png/person.png', false,isRequired: true),
            SizedBox(height: 1.5.h,),
            customTextFeild('Email Address', 'tomalbert@gmail.com', 'assets/png/lock.png', false,isRequired: true),
            SizedBox(height: 1.5.h,),
            CustomPhoneTextFeild(),
            SizedBox(height: 4.h),
            customButton("Update",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
              successDialog(context, "Done!", "Profile has been updated successfully.", "Ok", (){
                Get.back();
              });
            }),
          ],
        ),
      ),
    );
  }
}
