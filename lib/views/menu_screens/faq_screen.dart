import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/success_dialog.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("FAQ's",padding: 32.w),
              SizedBox(height: 4.h),
              customExpansionTile(title: "What is this platform about?",description: "This platform allows Non-Profit Organizations (NPOs) to create, manage, and promote their events while enabling community members to discover and participate in them."),
              SizedBox(height: 1.h),
              customExpansionTile(title: "Who can use this platform?",description: "This platform allows Non-Profit Organizations (NPOs) to create, manage, and promote their events while enabling community members to discover and participate in them."),
              SizedBox(height: 1.h),
              customExpansionTile(title: "Is the platform free to use?",description: "This platform allows Non-Profit Organizations (NPOs) to create, manage, and promote their events while enabling community members to discover and participate in them."),
              SizedBox(height: 1.h),
              customExpansionTile(title: "How do I sign up?",description: "This platform allows Non-Profit Organizations (NPOs) to create, manage, and promote their events while enabling community members to discover and participate in them."),
              SizedBox(height: 1.h),
              customExpansionTile(title: "Can individuals create events too?",description: "This platform allows Non-Profit Organizations (NPOs) to create, manage, and promote their events while enabling community members to discover and participate in them."),
              SizedBox(height: 3.5.h),
              customButton("Update",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
                successDialog(context, "Done!", "Password has been Updated successfully.", "Ok", (){
                  Get.back();
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}


Widget customExpansionTile({
  required String title,
  String? description,
  List<Widget>? children,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      border: Border.all(
        color: blackColor,
        width: 0.2.w,
      ),
    ),
    child: Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 5.w,),
        childrenPadding: EdgeInsets.zero, // ✅ removes default inside padding
        expandedCrossAxisAlignment: CrossAxisAlignment.start, // keeps alignment clean

        title: customText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: blackColor,
        ),

        iconColor: blackColor,
        collapsedIconColor: blackColor,

        children: [
          if (description != null)
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h), // ✅ only minimal padding
              child: customText(
                text: description!,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

          if (children != null) ...children!,
        ],
      ),
    ),
  );
}

