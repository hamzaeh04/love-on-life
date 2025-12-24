import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import '../../core/services/base_services.dart';
import '../../widgets/community_post_widget.dart';
import '../../widgets/community_suggestion_widget.dart';
import '../../widgets/create_post_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_comment_sheet.dart';
import '../../widgets/custom_drawer_widget.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CommunityController communityController = Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, top: 8.5.h),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  await communityController.GetAllPost();
                },
                builder: (BuildContext context, Widget child, IndicatorController controller) {
                  return child;
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      customText(
                        text: 'Create Post',
                        fontFamily: 'dmsans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 0.5.h),
                      createPost(),
                      SizedBox(height: 1.5.h),

                      Obx(() {
                        if (communityController.isLoadingPosts.value) {
                          return Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: SizedBox(
                              height: 30.h,
                              child: const Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }

                        final posts = communityController.getAllPostModel.value?.data;
                        if (posts == null || posts.isEmpty) {
                          return Center(child: Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: const Text("No posts available"),
                          ));
                        }

                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: posts.length,
                          separatorBuilder: (_, __) => SizedBox(height: 1.h),
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Column(
                              children: [
                                communityPost(
                                  post.userId?.profilePicture ?? '',
                                  post.userId?.fullname ?? '',
                                  post.description ?? '',
                                  post.createdAt ?? '',
                                  '',
                                  post.image ?? '',
                                  isLiked: post.isLiked,
                                  index: index,
                                  postId: post.id ?? '',
                                  commentTapped: () {
                                    showCommentsSheet(context, post.id ?? '', index);
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h, right: 4.w),
                                  child: const Divider(),
                                ),
                              ],
                            );
                          },
                        );
                      }),

                      // SizedBox(height: 1.h),
                      // customText(
                      //   text: 'Communities you may want to join',
                      //   fontFamily: 'dmsans',
                      //   fontSize: 15.5.sp,
                      //   fontWeight: FontWeight.w700,
                      // ),
                      // SizedBox(height: 1.h),
                      //
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       communitySuggestion('assets/png/event_detail_icon/image 1.png', 'Event Vista', '5.6k Followers'),
                      //       SizedBox(width: 3.w),
                      //       communitySuggestion('assets/png/event_detail_icon/image 2.png', 'Business Talks', '7.3k Followers'),
                      //       SizedBox(width: 3.w),
                      //       communitySuggestion('assets/png/community_icon/grpimg1.png', 'Tech Gamers', '4.7k Followers'),
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(height: 1.5.h),
                      // Container(
                      //   alignment: Alignment.center,
                      //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      //   margin: EdgeInsets.only(right: 4.w),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: whiteColor,
                      //     border: Border.all(color: textfieldBorderColor),
                      //     borderRadius: BorderRadius.circular(25.sp),
                      //   ),
                      //   child: customText(text: 'View all >'),
                      // ),
                       SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 0, left: 0, right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
                  child: customAppBar(
                    'Community',
                    ontap: () => _scaffoldKey.currentState!.openDrawer(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}