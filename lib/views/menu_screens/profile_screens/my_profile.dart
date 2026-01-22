import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/profile_network_image.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});

  final BaseService baseService = BaseService();
  final AuthController controller = Get.find<AuthController>();
  final prefs = SharedPreferencesMethod.storage;

  @override
  Widget build(BuildContext context) {
    controller.loadUserData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 5.h),

              // Back button
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: textfieldBorderColor, width: 0.2.w),
                  ),
                  padding: EdgeInsets.all(1.w),
                  child: Icon(Icons.arrow_back, size: 19.sp),
                ),
              ),

              SizedBox(height: 8.h),
// Image.network('${baseService.baseURL}${controller.userProfilePic.value}'),
              // Profile Image
              Center(
                child: Obx(() {
                  print("${baseService.baseURL}${controller.userProfilePic.value}");
                  return ProfileNetworkImage(
                    imageUrl: controller.userProfilePic.value.isNotEmpty
                        ? "${baseService.baseURL}${controller.userProfilePic.value}"
                        : "",
                    size: 30.w,
                    placeholder: "assets/png/home_icons/profile-placeholder.jpg",
                  );
                }),
              ),

              SizedBox(height: 5.h),

              // User Info
              Obx(() => Center(child: _buildInfoRow("First Name", controller.userName.value.isNotEmpty ? controller.userName.value : "User Name"))),
              SizedBox(height: 2.h),
              Center(child: _buildInfoRow("Email Address", controller.userEmail.value.isNotEmpty ? controller.userEmail.value : "Email")),
              SizedBox(height: 2.h),
              Obx(() => Center(child: _buildInfoRow("Contact Number", controller.userPhone.value.isNotEmpty ? controller.userPhone.value : '+19159969739'))),

              SizedBox(height: 5.h),

              // Edit Profile Button
              customButton(
                "Edit Profile",
                color: buttonPinkColor,
                fontweight: FontWeight.w700,
                fontsize: 16.sp,
                textColor: whiteColor,
                ontap: () {
                  Get.toNamed("edit");
                },
              ),

              SizedBox(height: 1.5.h),

              // Change Password Button
              customButton(
                "Change Password",
                color: backgroundColor,
                fontweight: FontWeight.w700,
                fontsize: 16.sp,
                textColor: buttonPinkColor,
                borderColor: buttonPinkColor,
                ontap: () {
                  Get.toNamed("change");
                },
              ),

              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable method for user info rows
  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customText(
          text: title,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: blackColor,
          height: 0.15.h,
        ),
        customText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: loginGreyColor,
        ),
      ],
    );
  }
}
