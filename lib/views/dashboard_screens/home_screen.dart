
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/core/services/apiendpoints.dart';
import 'package:love_on_life/outh_file/local_db_key.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:love_on_life/widgets/custom_app_bar.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/events_carousal.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/community_post_widget.dart';
import '../../widgets/custom_comment_sheet.dart';
import '../../widgets/custom_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CommunityController communityController = Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          // Scrollable area starts from here
          Positioned.fill(
            child: CustomRefreshIndicator(

              onRefresh: () async{
                communityController.getAllEvents(search: communityController.searchField.text, category: '', page: 1, limit: 10);
                communityController.GetAllPost();

              },
              builder: (BuildContext context, Widget child, IndicatorController controller) {
                return child;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 12.5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: InkWell(
                        onTap: (){
                          final prefs = SharedPreferencesMethod.storage;
                          print("${baseService.baseURL}${prefs.getString(LocalDBKeys.USERPROFILEPIC)}");
                        },
                        child: customText(
                          text: 'Events Near by You',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Obx(() {
                      // Show loading indicator while events are being fetched
                      if (communityController.isLoadingEvents.value) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30.h),
                            const Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }

                      // Show message if there are no events
                      if (communityController.eventsList.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(height: 12.5.h),
                            const Center(child: Text("No events found")),
                            SizedBox(height: 12.5.h),
                            Divider(),
                            SizedBox(height: 1.h),
                          ],
                        );
                      }

                      // Make sure the currentCarouselIndex is within range
                      final currentIndex = communityController.currentCarouselIndex.value;
                      final safeIndex = currentIndex.clamp(0, communityController.eventsList.length - 1);
                      final event = communityController.eventsList[safeIndex];

                      return Column(
                        children: [
                          EventsCarousel(),

                          SizedBox(height: 2.h),

                          // Horizontal buttons row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Share button
                              InkWell(
                                onTap: () {
                                  // TODO: Add share logic here
                                  communityController.shareEvent("${baseService.baseURL}${ApiEndPoints.getEventById(event.id ?? '')}");
                                },
                                child: homeShareWidget(
                                  "assets/png/home_icons/share_icon.png",
                                ),
                              ),
                              SizedBox(width: 2.w),

                              // Favorite button
                              Obx(() {
                                // Is line ko Obx ke andar hona zaroori hai taake ye reactive rahe
                                final isFav = communityController.eventsList[safeIndex].isFavorite ?? false;

                                return InkWell(
                                  onTap: () {
                                    communityController.toggleFavoriteEvent(event.id ?? '', safeIndex);
                                    communityController.eventsList.refresh(); // <- important
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal:2.5.w, vertical: 1.h),

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor,
                                      border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        isFav
                                            ? 'assets/png/community_icon/like_red.png'
                                            : 'assets/png/community_icon/Like.png',
                                        width: 6.w,
                                        height: 3.h,
                                        color: isFav ? buttonPinkColor : Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(width: 2.w),

                              // Join Now button
                              customButton(
                                "Join Now",
                                color: buttonPinkColor,
                                fontweight: FontWeight.w700,
                                fontsize: 16.sp,
                                textColor: whiteColor,
                                height: 5.h,
                                width: 35.w,
                                ontap: () {
                                  communityController.joinEvent(
                                    context,
                                    event.id ?? '',
                                    event.eventTitle ?? '',
                                    communityController.formatDate(event.date),
                                    communityController.formatTime(event.time),
                                  );
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 2.h),

                          // Community Feed header
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              children: [
                                customText(
                                  text: 'Community Feed',
                                  fontFamily: 'dmsans',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),


                    SizedBox(height: 1.h),

                    Obx(() {
                      if (communityController.isLoadingPosts.value) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: SizedBox(
                            height: 30.h,
                            child: const Center(
                              child: SizedBox(child: SizedBox.shrink()),
                            ),
                          ),
                        );
                      }

                      final posts =
                          communityController.getAllPostModel.value?.data;
                      if (posts == null || posts.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.55.h),
                            child: const Text("No posts available"),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: communityController.visiblePostCount.value
                            .clamp(0, posts.length),
                        separatorBuilder: (_, __) => SizedBox(height: 1.h),
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: communityPost(
                                  context: context,
                                  postId: post.id,
                                  UserId: post.userId?.id,
                                  post.userId?.profilePicture ?? '',
                                  post.userId?.fullname ?? '',
                                  post.description ?? '',
                                  post.createdAt ?? '',
                                  '',
                                  post.image ?? '',
                                  isLiked: post.isLiked,
                                  index: index,
                                  commentTapped: () {
                                    showCommentsSheet(
                                      context,
                                      post.id ?? '',
                                      index,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: const Divider(),
                              ),
                            ],
                          );
                        },
                      );
                    }),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          final totalPosts =
                              communityController
                                  .getAllPostModel
                                  .value
                                  ?.data
                                  ?.length ??
                              0;

                          if (communityController.visiblePostCount.value >=
                              totalPosts) {
                            return const SizedBox(); // hide button if all loaded
                          }

                          return moreContainer(
                            "Load more",
                            ontap: () {
                              communityController.loadMorePosts();
                            },
                          );
                        }),
                      ],
                    ),

                    SizedBox(height: 12.h), // bottom padding
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: customAppBar(
              "",
              ontap: () => _scaffoldKey.currentState!.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget moreContainer(String title, {VoidCallback? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
        //color: Colors.yellow,
        color: whiteColor,
        borderRadius: BorderRadius.circular(25.sp),
        border: Border.all(color: textfieldBorderColor, width: 0.2.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
        child: Row(
          children: [
            customText(
              text: title,
              fontFamily: 'dmsans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp),
          ],
        ),
      ),
    ),
  );
}

Widget homeShareWidget(
  String path, {
  double? height,
  double? width,
  double? hori,
  double? vert,
  Color? color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: hori ?? 2.5.w,
      vertical: vert ?? 1.h,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: whiteColor,
      border: Border.all(color: textfieldBorderColor, width: 0.3.w),
    ),
    child: Center(
      child: Image.asset(
        path,
        width: width ?? 6.w,
        height: height ?? 3.h,
        color: color ?? Colors.grey,
      ),
    ),
  );
}
