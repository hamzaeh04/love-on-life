import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/widgets/custom_header.dart';
import 'package:sizer/sizer.dart';

class BlockedUsers extends StatelessWidget {
  BlockedUsers({super.key});

  final CommunityController communityController =
  Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      communityController.getAllBlockedUsers();
    });

    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(height: 3.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: customHeader("Blocked Users"),
          ),
          Expanded(child: Obx(() {

            /// Loading
            if (communityController.isBlockedUsersLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final blockedUsers =
                communityController.getBlockedUsersModel.value?.data;

            /// Empty State
            if (blockedUsers == null || blockedUsers.isEmpty) {
              return const Center(
                child: Text("No blocked users found"),
              );
            }

            /// List
            return ListView.builder(
              itemCount: blockedUsers.length,

              itemBuilder: (context, index) {

                final user = blockedUsers[index];

                return blockList(
                  user.profilePicture ?? "",
                  user.fullname ?? "",
                  user.email ?? "",
                  user.id ?? "",
                );
              },
            );
          }),)
        ],
      ),
    );
  }
}

Widget blockList(
    String imagePath,
    String name,
    String email,
    String id,
    ) {

  final CommunityController communityController =
  Get.find<CommunityController>();

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 5.w,
      vertical: 1.h,
    ),

    child: Row(
      children: [

        /// Profile Image
        CircleAvatar(
          radius: 5.w,

          backgroundImage: imagePath.isNotEmpty
              ? NetworkImage(
            "${communityController.baseService.baseURL}$imagePath",
          )
              : null,

          child: imagePath.isEmpty
              ? customText(
            text: name.isNotEmpty ? name[0] : "?",
          )
              : null,
        ),

        SizedBox(width: 3.w),

        /// Name + Email
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              customText(
                text: name,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),

              customText(
                text: email,
                fontSize: 14.5.sp,
              ),
            ],
          ),
        ),

        /// Menu
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          color: Colors.white,
          icon: const Icon(Icons.more_vert),

          onSelected: (value) {

            if (value == 'unblock') {
              communityController.unblockUser(id);
              debugPrint("Unblock user id: $id");

              /// Call unblock API here
            }
          },

          itemBuilder: (context) => [

            PopupMenuItem(
              value: 'unblock',
              child: Row(
                children: [
                  customText(text: 'Unblock User'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}