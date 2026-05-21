import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/widgets/profile_network_image.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
Widget createPost() {
  BaseService baseService = BaseService();
  final AuthController controller = Get.find<AuthController>();
  final CommunityController communityController = Get.find<CommunityController>();
  return Container(
    margin: EdgeInsets.only(right: 4.w),
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(color: textfieldBorderColor),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 8.w,
              width: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //color: Colors.yellow
              ),
              child: Obx(() {
                return ProfileNetworkImage(
                  imageUrl:
                  controller.userProfilePic.value.isNotEmpty
                      ? "${baseService.baseURL}${controller.userProfilePic.value}"
                      : "",
                  size: 8.w,
                  placeholder:
                  "assets/png/home_icons/profile-placeholder.jpg",
                );
              }),
            ),
            SizedBox(width: 1.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                      () => customText(
                    text:
                    controller.userName.value.isNotEmpty
                        ? controller.userName.value
                        : "User Name",
                        fontFamily: 'dmsans',
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.15.h,
                  ),
                ),
                customText(
                  text: 'Participant',
                  fontFamily: 'dmsans',
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF83848D),
                  height: 1.2
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 0.2.h),
        TextField(
          controller: communityController.postDescField,
          decoration: InputDecoration(
            hintText: 'Write something about the events',
            hintStyle: TextStyle(
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF83848D),
            ),
            border: InputBorder.none, // removes underline/border
            isDense: true, // removes extra vertical padding
            contentPadding: EdgeInsets.zero, // removes internal padding
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          final image = communityController.selectedPostImage.value;
          final video = communityController.selectedPostVideo.value;

          if (image == null && video == null) {
            return const SizedBox();
          }

          return Padding(
            padding: EdgeInsets.only(top: 1.5.h),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: SizedBox(
                    width: 22.w,
                    height: 11.h,
                    child:
                    image != null ?
                        Image.file(
                          image,
                          fit: BoxFit.cover,
                        ) : Stack(
                      alignment: Alignment.center,
                      children: [
                        // 🎥 Video thumbnail
                        communityController.selectedPostVideoThumbnail.value != null
                            ? Image.file(
                                communityController.selectedPostVideoThumbnail.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Container(
                                color: Colors.black12,
                              ),

                        // ▶ Play icon
                        Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ],
                    ),
                  ),
                ),

                // ❌ Remove Button (top-right)
                InkWell(
                  onTap: () {
                    communityController.removePostMedia();
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.sp),
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: InkWell(
            onTap: (){
              communityController.pickImagePost();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/png/Image.png', width: 5.w),
                SizedBox(width: 2.5.w),
                customText(
                  text: 'Image/video',
                  fontFamily: 'dmsans',
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    communityController.createPost();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: buttonPinkColor,
                      borderRadius: BorderRadius.circular(12.sp),

                    ),

                    child: customText(
                      textAlign: TextAlign.center,
                      text: 'Post',
                      fontFamily: 'dmsans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
