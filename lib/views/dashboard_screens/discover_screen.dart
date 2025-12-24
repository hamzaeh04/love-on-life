
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/views/dashboard_screens/ticket_screen.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/discover_screen_widget.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_ticket_dialog.dart';
import 'dart:async';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  final SearchController2 searchController = Get.put(SearchController2());
  final CommunityController communityController = Get.find<CommunityController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Inside your DiscoverScreen or a separate helper
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          /// Scrollable content
          Positioned.fill(

            child: Obx(
                  () => CustomRefreshIndicator(
                onRefresh: () async {
                  await communityController.getAllEvents(
                      search: communityController.searchField.text,
                      category: '',
                      page: 1,
                      limit: 10,
                      isLoadMore: false
                  );
                },
                builder: (BuildContext context, Widget child, IndicatorController controller) {
                  return child;
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: searchController.isSearch.value == false
                      ? EdgeInsets.only(top: 9.h)
                      : EdgeInsets.only(top: 9.5.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.5.h),

                        /// 🔹 Search & Filter
                        _buildSearchFilter(),

                        SizedBox(height: 1.h),

                        /// 🔹 Event List
                        Obx(() {
                          if (communityController.isLoadingEvents.value) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 30.h,),
                                Center(child: CircularProgressIndicator()),
                              ],
                            );
                          }

                          if (communityController.eventsList.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: 30.h,),

                                Center(child: Text("No events found")),
                              ],
                            );
                          }

                          return ListView.builder(
                            itemCount: communityController.eventsList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final event = communityController.eventsList[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: discoverWidget(
                                  index: index,
                                  eventId: event.id,
                                  imagePath: event.image ?? '',
                                  eventName: event.eventTitle ?? '',
                                  description: event.description ?? '',
                                  date: communityController.formatDate(event.date),
                                  time: communityController.formatTime(event.time),
                                  ticketPrice: event.price?.toString() ?? 'Free',
                                  tag: event.category ?? '',
                                  isFavorite: event.isFavorite,
                                  noOfPeople: event.userIds?.length.toString() ?? '0',
                                  ticketsLeft: event.ticketType ?? '',
                                  onViewLocation: () {
                                    print("📍 Location: ${event.coordinates}");
                                  },
                                  onJoinNow: () {
                                    print("🎟 Join Event: ${event.id}");
                                    communityController.joinEvent(context, event.id ?? '', event.eventTitle ?? '', communityController.formatDate(event.date), communityController.formatTime(event.time),);
                                  },
                                  onFavIconTap: () {
                                    // ✅ Optimistic UI: instant update
                                    event.isFavorite = !(event.isFavorite ?? false);
                                    communityController.getAllEventsModel.refresh();

                                    // ✅ API call
                                    communityController.toggleFavoriteEvent(event.id ?? '', index);
                                  },
                                ),
                              );
                            },
                          );
                        }),

                        SizedBox(height: 13.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Fixed AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // child: Obx(
            //       () => searchController.isSearch.value == false
            //       ? customAppBar(
            //     "Discover Events",
            //     ontap: () => _scaffoldKey.currentState!.openDrawer(),
            //   )
            //       : _buildSearchBar(context),
            // ),
            child: customAppBar('Discover Events',
            ontap: () => _scaffoldKey.currentState!.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildSearchFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(25.sp),
              border: Border.all(color: textfieldBorderColor, width: 0.4.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
              child: Row(
                children: [
                  Image.asset(
                    "assets/png/home_icons/search_icon.png",
                    width: 5.w,
                    color: searchColor,
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: TextField(
                      controller: communityController.searchField,
                      onTap: () => searchController.isSearch.value = true,
                      onChanged: (value) {
                        searchController.isSearch.value = true;

                        // Cancel previous timer
                        if (_debounce?.isActive ?? false) _debounce!.cancel();

                        // Start new timer
                        _debounce = Timer(const Duration(milliseconds: 500), () async {
                          if (value.isEmpty) {
                            // Show full event list
                            await communityController.getAllEvents(
                              search: '',
                              category: '',
                              page: 1,
                              limit: 10,
                              isLoadMore: false,
                            );
                          } else {
                            // Call API with search query
                            await communityController.getAllEvents(
                              search: value,
                              category: '',
                              page: 1,
                              limit: 10,
                              isLoadMore: false,
                            );
                          }
                        });
                      },
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Search here...",
                        hintStyle: TextStyle(color: searchColor, fontSize: 15.sp),
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 3.w),
        InkWell(
          onTap: () async {
            // Optional: force search manually
            final text = communityController.searchField.text;
            await communityController.getAllEvents(
              search: text,
              category: '',
              page: 1,
              limit: 10,
            );
          },
          child: Container(
            height: 5.h,
            width: 5.h,
            decoration: BoxDecoration(color: buttonPinkColor, shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                "assets/png/home_icons/search_icon.png",
                color: Colors.white,
                width: 4.w,
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
      child: Row(
        children: [
          InkWell(
            onTap: () => searchController.isSearch.value = false,
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                border: Border.all(color: textfieldBorderColor, width: 0.2.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(1.w),
                child: Icon(Icons.arrow_back, size: 19.sp),
              ),
            ),
          ),
          SizedBox(width: 30.w),
          customText(text: 'Search', fontSize: 17.sp, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}


Widget options(String title) {
  return Column(
    children: [
      Row(
        children: [
          customText(text: title, fontSize: 15.sp, fontWeight: FontWeight.w400),
          Spacer(),
          Icon(
            Icons.cancel_outlined,
            color: Colors.black.withOpacity(0.5),
            size: 16.sp,
          ),
        ],
      ),
      Padding(padding: EdgeInsets.symmetric(vertical: 0.5.h), child: Divider()),
    ],
  );
}
