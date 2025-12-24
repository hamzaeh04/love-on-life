import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:sizer/sizer.dart';

import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/controllers/ticket_controller.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/ticketClipper.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({super.key});

  final DashboardController dashboardController =
  Get.find<DashboardController>();
  final TicketController ticketController = Get.find<TicketController>();
  final CommunityController communityController =
  Get.find<CommunityController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(height: 11.h),

                  /// 🔹 Status Tabs
                  rowWidget(),

                  SizedBox(height: 1.h),

                  /// 🔹 Ticket List
                  Expanded(
                    child: Obx(() {
                      /// Initial Loader
                      if (ticketController.isLoading.value &&
                          ticketController.currentPage.value == 1) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final tickets = ticketController
                          .getTicketModel.value?.data?.tickets ??
                          [];

                      if (tickets.isEmpty) {
                        return Center(
                          child: customText(text: "No tickets found"),
                        );
                      }

                      return CustomRefreshIndicator(
                        onRefresh: () async {
                          ticketController.resetPagination();
                          await ticketController.getTickets(
                            page: 1,
                            limit: 10,
                            status: ticketController.currentStatus.value,
                          );
                        },
                        builder: (context, child, controller) {
                          return Transform.translate(
                            offset: Offset(0, controller.value * 80),
                            child: child,
                          );
                        },
                        child: ListView.builder(
                          controller: ticketController.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: tickets.length +
                              (ticketController.isFetchingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            /// Pagination Loader
                            if (index == tickets.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final ticket = tickets[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: TicketWidget(
                                width: double.infinity,
                                height: 22.h,
                                dyOffset: 2.h,
                                isCornerRounded: true,
                                color: whiteColor,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 1.5.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          /// 🔹 Title Row
                                          Row(
                                            children: [
                                              Expanded(
                                                child: customText(
                                                  text: ticket
                                                      ?.eventId?.eventTitle,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: lightPurple,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.sp),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.3.h,
                                                ),
                                                child: customText(
                                                  text: ticket?.ticketNumber,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: darkPurpleColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 1.h),

                                          /// 🔹 Date & Price
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _infoBox(
                                                  color:
                                                  const Color(0xFFD9F3FB),
                                                  icon:
                                                  'assets/png/event_detail_icon/date&time.png',
                                                  title: communityController
                                                      .formatDate(ticket
                                                      ?.eventId?.date),
                                                  subtitle: communityController
                                                      .formatTime(ticket
                                                      ?.eventId?.time),
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Expanded(
                                                child: _infoBox(
                                                  color:
                                                  const Color(0xFFFFE4F8),
                                                  icon:
                                                  'assets/png/bottom_nav_icon/ticket.png',
                                                  title:
                                                  "\$ ${ticket?.price}",
                                                  subtitle: ticket.status.toString(),
                                                  iconColor:
                                                  buttonPinkColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 4.25.h),

                                          /// 🔹 Action Buttons
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/png/home_icons/barcode.png",
                                                width: 12.h,
                                              ),
                                              SizedBox(width: 3.w),
                                              Expanded(
                                                child: customButton(
                                                  "Cancel",
                                                  color: ticketGreyColor,
                                                  height: 4.h,
                                                  textColor: blackColor,
                                                  ontap: () {
                                                    ticketController.deleteTicket("${ticket.id}");
                                                    // ticketController.getTickets(
                                                    //   page: 1,
                                                    //   limit: 10,
                                                    //   status: ticketController.currentStatus.value,
                                                    // );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Expanded(
                                                child: customButton(
                                                  "Pay",
                                                  color: ticketBlueColor,
                                                  height: 4.h,
                                                  textColor: whiteColor,
                                                  ontap: () {
                                                    Get.toNamed("card");
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// 🔹 Dashed Line
                                    Positioned(
                                      top: 12.9.h,
                                      right: 3.5.w,
                                      child: Image.asset(
                                        'assets/png/home_icons/line.png',
                                        height: 0.14.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Frosted AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: customAppBar(
                    'Tickets',
                    ontap: () =>
                        _scaffoldKey.currentState!.openDrawer(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Info Box Widget
  Widget _infoBox({
    required Color color,
    required String icon,
    required String title,
    required String subtitle,
    Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 7.w, color: iconColor),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(fontSize: 14.sp, text: title),
              customText(fontSize: 13.sp, text: subtitle),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Status Tabs
Widget rowWidget() {
  final DashboardController controller = Get.find<DashboardController>();
  final TicketController ticketController = Get.find<TicketController>();

  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.sp),
        border: Border.all(color: textfieldBorderColor),
      ),
      child: Row(
        children: List.generate(controller.options.length, (index) {
          final bool isSelected =
              controller.selectedIndex.value == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.selectedIndex.value = index;

                final status = index == 0
                    ? 'pending'
                    : index == 1
                    ? 'confirmed'
                    : 'cancelled';

                ticketController.resetPagination();
                ticketController.getTickets(
                  page: 1,
                  limit: 10,
                  status: status,
                );
              },
              child: Container(
                margin: EdgeInsets.all(0.5.w),
                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  color:
                  isSelected ? buttonPinkColor : Colors.transparent,
                ),
                child: Center(
                  child: customText(
                    text: controller.options[index],
                    fontSize: 14.sp,
                    color:
                    isSelected ? whiteColor : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  });
}
