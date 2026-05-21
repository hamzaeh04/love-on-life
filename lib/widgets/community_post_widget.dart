import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:love_on_life/widgets/custom_app_bar.dart';
import 'package:love_on_life/widgets/profile_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../outh_file/local_db_key.dart';
import '../utils/utility.dart';
import 'custom_reason_widget.dart';
import 'network_media_player.dart';

Widget communityPost(
  String path,
  String title,
  String desc,
  String time,
  String path2,
  String mainImage, {
  int? index,
  bool? isGroup = false,
  bool? isGroupOnly = true,
  bool? isFollow = true,
  bool? isLiked = false,
  String? postId,
  VoidCallback? likeTapped,
  VoidCallback? commentTapped,
  BuildContext? context,
      String? UserId
}) {
  final CommunityController communityController = Get.find<CommunityController>();
  final prefs = SharedPreferencesMethod.storage;
  var id = prefs.getString(LocalDBKeys.USERID);
  var post = communityController.getAllPostModel.value?.data?[index!];
  bool isMyPost = post?.userId?.id == id;

  return Container(
    margin: EdgeInsets.only(right: 4.w),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---------------- HEADER ----------------
        Row(
          children: [
            isGroup == true
                ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ProfileNetworkImage(
                      imageUrl: '${baseService.baseURL}$path',
                      size: 10.w,
                      placeholder: 'assets/png/community_icon/person3.png',
                    ),
                    if (isGroupOnly == true)
                      Positioned(
                        bottom: 0,
                        right: -1.2.w,
                        child: ProfileNetworkImage(
                          imageUrl: '${baseService.baseURL}$path',
                          size: 5.5.w,
                          placeholder: 'assets/png/community_icon/person1.png',
                        ),
                      ),
                  ],
                ) : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                '${baseService.baseURL}$path',
                width: 11.w,
                height: 11.w,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/png/community_icon/person1.png',
                    width: 11.w,
                    height: 11.w,
                    fit: BoxFit.cover,
                  );
                },

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 11.w,
                      height: 11.w,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            // : ProfileNetworkImage(
                //   imageUrl: '${baseService.baseURL}$path',
                //   size: 11.w,
                //   placeholder: 'assets/png/community_icon/person1.png',
                // ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: title,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.3.h),
                  customText(
                    text:
                        "${communityController.formatDate(time)} • ${communityController.formatTime2(time)}",
                    fontSize: 13.sp,
                    color: const Color(0xFF666666),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              color: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.sp),
              ),
              offset: Offset(0, 25),
              onSelected: (value) {
                if (value == 'delete') {
                  communityController.deletePost(postId ?? "");
                } else if (value == 'report') {
                  showReasonSheet(context!, "", postId!,);
                } else if (value == 'block') {
                  print("Block User tapped");
                  communityController.blockUser(UserId!);
                  // Example:
                  // userController.blockUser(userId);
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem<String>(
                      value: isMyPost ? 'delete' : 'report',
                      child: customText(
                        text: isMyPost ? "Delete" : "Report",
                        color: Colors.red,
                      ),
                    ),
                    isMyPost
                        ? const PopupMenuItem(
                      enabled: false,
                      height: 0,
                      child: SizedBox.shrink(),
                    )
                        : PopupMenuItem(
                      value: "block",
                      child: customText(
                        text: "Block User",
                        color: Colors.red,
                      ),
                    ),
                  ],
              child: Image.asset(
                'assets/png/community_icon/DotsThreeVertical.png',
                width: 7.w,
              ),
            ),
          ],
        ),

        SizedBox(height: 0.8.h),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: customText(text: desc, fontSize: 14.sp),
        ),
        SizedBox(height: 0.8.h),

        /// ---------------- POST IMAGE ----------------
        ClipRRect(
          borderRadius: BorderRadius.circular(15.sp),
          child: NetworkMediaPlayer(
            mediaUrl: '${baseService.baseURL}$mainImage',
            width: double.infinity,
            height: 36.h,
            placeholder: 'assets/png/event_detail_icon/people2.jpg',
          ),
        ),

        /// ---------------- LIKE / COMMENT BAR ----------------
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Like Button ---
              Obx(() {
                // Post ka data direct list se uthao
                final currentPost =
                    communityController.getAllPostModel.value?.data?[index!];
                final postIsLiked = currentPost?.isLiked ?? false;

                return GestureDetector(
                  onTap: () async {
                    if (currentPost?.id != null) {
                      // Specific post ko like karo
                      await communityController.toggleLike(
                        "${currentPost!.id}",
                        index!,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        postIsLiked
                            ? 'assets/png/community_icon/like_red.png'
                            : 'assets/png/community_icon/Like.png',
                        width: 5.5.w,
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: 'Like',
                        fontSize: 12.5.sp,
                        color: postIsLiked ? Colors.red : Colors.black,
                      ),
                    ],
                  ),
                );
              }),

              // Comment Button
              GestureDetector(
                onTap: commentTapped,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/community_icon/Comment.png',
                      width: 4.9.w,
                    ),
                    SizedBox(width: 2.w),
                    customText(text: 'Comments', fontSize: 12.5.sp),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// ---------------- LIKES INFO ----------------
        Obx(() {
          final currentPost =
              communityController.getAllPostModel.value?.data?[index!];
          final currentLikes = currentPost?.likesCount ?? 0;

          return RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'dmsans',
                fontSize: 13.5.sp,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: 'Liked by '),
                TextSpan(
                  text: "$currentLikes ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: 'users'),
              ],
            ),
          );
        }),

        SizedBox(height: 0.6.h),

        /// ---------------- TOP COMMENT ----------------
        Obx(() {
          final currentPost =
              communityController.getAllPostModel.value?.data?[index!];
          final topComment =
              currentPost?.comments?.isNotEmpty == true
                  ? currentPost!.comments!.first
                  : null;

          return currentPost?.commentsCount == 0
              ? const SizedBox.shrink()
              : RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'dmsans',
                    fontSize: 13.5.sp,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: currentPost?.userId?.fullname ?? "User",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: " ${topComment?.comment ?? ''}"),
                  ],
                ),
              );
        }),
      ],
    ),
  );
}
