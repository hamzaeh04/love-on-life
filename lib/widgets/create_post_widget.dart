import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/views/dashboard_screens/community_screen.dart';
import 'package:love_on_life/widgets/profile_network_image.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'create_post_widget.dart';

Widget createPost() {
  BaseService baseService = BaseService();
  final AuthController controller = Get.find<AuthController>();
  final CommunityController communityController = Get.find<CommunityController>();
  return Container(
    margin: EdgeInsets.only(right: 4.w),
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
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
                // customText(
                //   text: 'Eddie Sanz',
                //   fontFamily: 'dmsans',
                //   fontSize: 14.5.sp,
                //   fontWeight: FontWeight.w500,
                //   height: 0.15.h,
                // ),
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
            // Spacer(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20.sp),
            //     color: publicButtonColor,
            //     border: Border.all(color: textfieldBorderColor),
            //   ),
            //   child: PopupMenuButton<String>(
            //     color: whiteColor,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.sp),
            //     ),
            //     elevation: 2,
            //     offset: const Offset(0, 35),
            //
            //     onSelected: (String value) {
            //       communityController.postVisibility.value = value;
            //     },
            //
            //     itemBuilder: (context) => const [
            //       PopupMenuItem(value: 'Public', child: Text('Public')),
            //       PopupMenuItem(value: 'Private', child: Text('Private')),
            //       PopupMenuItem(value: 'Friends Only', child: Text('Friends Only')),
            //     ],
            //
            //     child: Obx(() => Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         customText(
            //           text: communityController.postVisibility.value,
            //           fontFamily: 'dmsans',
            //           fontSize: 12.5.sp,
            //           fontWeight: FontWeight.w400,
            //         ),
            //         SizedBox(width: 1.w),
            //         Icon(Icons.keyboard_arrow_down, size: 14.5.sp),
            //       ],
            //     )),
            //   ),
            // )


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
          if (communityController.selectedPostImage.value == null) {
            return const SizedBox();
          }

          return Padding(
            padding: EdgeInsets.only(top: 1.5.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: Image.file(
                    communityController.selectedPostImage.value!,
                    width: 20.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                  ),
                ),

                // ❌ Close icon in center
                InkWell(
                  onTap: () {
                    communityController.removePostImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6.sp),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Obx(() {
        //       if (!communityController.canPost.value) {
        //         return const SizedBox();
        //       }
        //
        //       return Padding(
        //         padding: EdgeInsets.only(top: 0.5.h, bottom: 0.6.h, right: 2.w),
        //         child: SizedBox(
        //           width: 19.w,
        //           height: 3.h,
        //           child:
        //         ),
        //       );
        //     })
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              InkWell(
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
                    SizedBox(width: 42.w,),
                    InkWell(
                      onTap: () {
                        // 👉 call create post API here
                        //communityController.createPost();
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
              // SizedBox(width: 10.w),
              // Row(
              //   children: [
              //     Image.asset('assets/png/location.png', width: 5.w),
              //     SizedBox(width: 2.5.w),
              //     customText(
              //       text: 'Check-in',
              //       fontFamily: 'dmsans',
              //       fontSize: 12.5.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ],
              // ),
              // SizedBox(width: 10.w),
              // Row(
              //   children: [
              //     Image.asset('assets/png/CheckCircle.png', width: 5.w),
              //     SizedBox(width: 2.5.w),
              //     customText(
              //       text: 'Activity',
              //       fontFamily: 'dmsans',
              //       fontSize: 12.5.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ],
              // )
            ],
          ),
        ),


      ],
    ),
  );
}
