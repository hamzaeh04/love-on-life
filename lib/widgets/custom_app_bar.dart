import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/widgets/profile_network_image.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

BaseService baseService = BaseService();

// Ensure controller is initialized safely
final AuthController controller = Get.find<AuthController>();

Widget customAppBar(String title, {VoidCallback? ontap}) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        padding: EdgeInsets.only(top: 4.5.h, left: 4.w, right: 4.w, bottom: 1.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
        ),
        child: Row(
          children: [
            // Profile Image
            Obx(() => SizedBox(
              height: 10.w, // fixed height to match image size
              width: 10.w,  // fix width to prevent overflow
              child: InkWell(
                onTap: ontap,
                child: ProfileNetworkImage(
                  imageUrl: controller.userProfilePic.value.isNotEmpty
                      ? "${baseService.baseURL}${controller.userProfilePic.value}"
                      : "",
                  size: 10.w, // match width/height
                  placeholder: "assets/png/home_icons/profile-placeholder.jpg",
                ),
              ),
            )),

            SizedBox(width: 2.w), // small spacing

            // Title
            Expanded(
              child: Center(
                child: customText(
                  text: title,
                  fontFamily: 'dmsans',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Bell Icon
            SizedBox(
              height: 4.5.h,
              width: 8.5.w,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed("notification");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                      height: 4.5.h,
                      width: 8.5.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                      ),
                      child: Image.asset(
                        'assets/png/bell_icon.png',
                        width: 2.5.w,
                        height: 2.5.h,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2.2.w,
                    top: 1.h,
                    child: Image.asset(
                      'assets/png/bell_icon2.png',
                      width: 1.6.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
