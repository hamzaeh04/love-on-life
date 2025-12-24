import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/discover_screen_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final CommunityController communityController = Get.find<CommunityController>();
    final SearchController2 searchController = Get.put(SearchController2());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(height: 5.h),

            // 🔹 Header + Search
            customHeader('Favorites'),
            SizedBox(height: 2.h),
            buildSearchFilter(),

            SizedBox(height: 2.h),

            // 🔹 Events List with ONE CustomRefreshIndicator
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  await communityController.getFavoriteEvents();
                },
                builder: (BuildContext context, Widget child, IndicatorController controller) {
                  return Stack(
                    children: [
                      child,
                      if (controller.isDragging || controller.isLoading)
                        Positioned(
                          top: 30.h,
                          left: 0,
                          right: 0,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                },
                child: Obx(() {
                  final events = communityController.getFavoriteEventModel.value?.data;

                  if (communityController.isLoadingEvents.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (events == null || events.isEmpty) {
                    return Center(child: Text("No events found"));
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: discoverWidget(
                          index: index,
                          imagePath: event.image ?? '',
                          eventName: event.eventTitle ?? '',
                          description: event.description ?? '',
                          date: communityController.formatDate(event.date) ?? '',
                          time: communityController.formatTime(event.time) ?? '',
                          ticketPrice: event.price.toString(),
                          tag: event.category ?? '',
                          noOfPeople: event.userIds?.length.toString() ?? '0',
                          ticketsLeft: event.ticketType ?? '',
                          context: context,
                          isFavorite: true,
                          onViewLocation: () => print("View Location clicked for index $index"),
                          onJoinNow: () => print("Join Now clicked for index $index"),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchFilter() {
    final CommunityController communityController = Get.find<CommunityController>();
    final SearchController2 searchController = Get.put(SearchController2());

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

                        // Use debounce inside controller
                        searchController.debounceSearch(value);
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
}
