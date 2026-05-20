import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import '../constants/constants_widgets.dart';
import '../core/services/base_services.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import 'custom_reason_widget.dart';

void showCommentsSheet(BuildContext context, String postId, int postIndex, ) {
  final CommunityController communityController = Get.find<CommunityController>();
  final prefs = SharedPreferencesMethod.storage;
  var id = prefs.getString(LocalDBKeys.USERID);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, innerScrollController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
              height: 0.5.h, width: 10.w,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
            customText(text: 'Comments', fontSize: 15.sp, fontWeight: FontWeight.bold),
            const Divider(),

            Expanded(
              child: Obx(() {
                final currentPost = communityController.getAllPostModel.value?.data?[postIndex];
                final comments = currentPost?.comments ?? [];

                if (comments.isEmpty) {
                  return Center(child: customText(text: "No comments yet."));
                }

                return ListView.builder(
                  controller: innerScrollController,
                  padding: EdgeInsets.only(bottom: 2.h),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final commentOwner = comment.userId?.id;
                    bool isMyComment = commentOwner == id;

                    return ListTile(
                      key: ValueKey(comment.id),
                      leading: CircleAvatar(
                        radius: 18.sp,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: (comment.userId?.profilePicture?.isNotEmpty ?? false)
                            ? CachedNetworkImageProvider("${BaseService().baseURL}${comment.userId!.profilePicture}")
                            : const AssetImage("assets/png/profile_img.png") as ImageProvider,
                      ),
                        trailing: PopupMenuButton<String>(
                          color: whiteColor,
                          icon: Icon(Icons.more_vert, size: 18.sp),
                          onSelected: (value) async {
                            if (value == 'delete') {

                              final commentId = comment.id ?? "";

                              // Backup for rollback
                              final removedComment = currentPost?.comments?[index];
                              final oldCount = currentPost?.commentsCount ?? 0;

                              /// OPTIMISTIC UPDATE
                              currentPost?.comments?.removeAt(index);
                              currentPost?.commentsCount = oldCount - 1;

                              // Refresh UI instantly
                              communityController.getAllPostModel.refresh();

                              /// API CALL
                              final success = await communityController.deleteComment(
                                postId,
                                commentId,
                              );

                              /// ROLLBACK IF FAILED
                              if (!success) {
                                currentPost?.comments?.insert(index, removedComment!);
                                currentPost?.commentsCount = oldCount;

                                communityController.getAllPostModel.refresh();

                                Utils.showToast("Failed to delete comment", true);
                              } else {
                                Utils.showToast("Comment deleted", false);
                              }

                            } else if (value == 'report') {
                              // Utils.showToast('Reported Successfully', false);
                              final commentId = comment.id ?? "";

                              showReasonSheet(context, commentId, postId);

                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: isMyComment ? 'delete' : 'report',
                              child: customText(
                                text: isMyComment ? "Delete" : "Report",
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      // trailing: PopupMenuButton<String>(
                      //   icon: Icon(Icons.more_vert, size: 18.sp),
                      //   onSelected: (value) async {
                      //     if (value == 'delete') {
                      //       print("${post} = ${id}");
                      //       final commentId = comment.id ?? "";
                      //       final success = await communityController.deleteComment(postId, commentId);
                      //
                      //       if (success) {
                      //         // Successfully delete hone pe UI update
                      //         currentPost?.comments?.removeAt(index);
                      //         currentPost?.commentsCount = (currentPost.commentsCount ?? 1) - 1;
                      //         communityController.getAllPostModel.refresh();
                      //       }
                      //     } else if (value == 'report') {
                      //       print("${post} = ${id}");
                      //       Utils.showToast('Reported Successfully', false);
                      //     }
                      //   },
                      //   itemBuilder:
                      //       (context) => [
                      //     PopupMenuItem<String>(
                      //       value: isMyComment ? 'delete' : 'report',
                      //       child: customText(
                      //         text: isMyComment ? "Delete" : "Report",
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ],
                      // ),


                      title: customText(
                          text: comment.userId?.fullname ?? "User",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: blackColor
                      ),
                      subtitle: customText(
                          text: comment.comment ?? '',
                          fontSize: 14.sp,
                          color: blackColor
                      ),
                    );
                  },
                );
              }),
            ),

            // TextField Area
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
                left: 4.w, right: 4.w, top: 1.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: communityController.addCommentField,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.sp), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  IconButton(
                    onPressed: () async {
                      if (communityController.addCommentField.text.trim().isNotEmpty) {
                        // Naya comment add karne ka logic
                        await communityController.addComment(postId, postIndex);

                        // Count update karein bahar dikhane ke liye
                        final currentPost = communityController.getAllPostModel.value?.data?[postIndex];
                        currentPost?.commentsCount = (currentPost.commentsCount ?? 0) + 1;
                        communityController.getAllPostModel.refresh();
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.blue),
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


