import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/ticketClipper.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({super.key});

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 13.h),
                    rowWidget(),
                    SizedBox(height: 1.h),

                    // 🔹 Ticket list
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // disable inner scroll
                      shrinkWrap: true, // ListView height wraps its children
                      padding: EdgeInsets.zero,
                      itemCount: controller.discoverList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 2.h,
                          ), // spacing between tickets
                          child: TicketWidget(
                            width: double.infinity,
                            height: 22.h,
                            dyOffset: 2.h,
                            isCornerRounded: true,
                            color: whiteColor,
                            child: Stack(
                              children: [
                                // Main content inside ticket
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 1.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // 🔹 Title row with tag and icons
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 0.3.h,
                                            ),
                                            child: customText(
                                              text:
                                                  controller.ticketList[index],
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 0.6.h,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: lightPurple,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      10.sp,
                                                    ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.3.h,
                                                ),
                                                child: customText(
                                                  text: "GBD998",
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: darkPurpleColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: lightPurple,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: EdgeInsets.all(2.w),
                                                child: Image.asset(
                                                  "assets/png/home_icons/location.png",
                                                  width: 3.w,
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 0.2.h,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: lightPurple,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding: EdgeInsets.all(1.w),
                                                  child: Image.asset(
                                                    "assets/png/home_icons/qrcode.png",
                                                    width: 5.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 0.8.h),

                                      // 🔹 Date & Tickets row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Date & Time
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 3.w,
                                                top: 1.h,
                                                bottom: 1.h,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      10.sp,
                                                    ),
                                                color: const Color(0xFFD9F3FB),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/png/event_detail_icon/date&time.png',
                                                    width: 7.5.w,
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customText(
                                                        text: "10 Sep, 2025",
                                                        fontFamily: 'dmsans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      customText(
                                                        text:
                                                            "12:00 AM - 2:00 PM",
                                                        fontFamily: 'dmsans',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w),

                                          // Tickets
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      10.sp,
                                                    ),
                                                color: const Color(0xFFFFE4F8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 3.w,
                                                  top: 1.h,
                                                  bottom: 1.h,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              5,
                                                            ),
                                                        child: Image.asset(
                                                          'assets/png/bottom_nav_icon/ticket.png',
                                                          width: 5.w,
                                                          color:
                                                              buttonPinkColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 3.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customText(
                                                          text: "\$ 40",
                                                          fontFamily: 'dmsans',
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        customText(
                                                          text:
                                                              "5 Tickets Purchase",
                                                          fontFamily: 'dmsans',
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 3.5.h),
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
                                              fontweight: FontWeight.w500,
                                              fontsize: 14.sp,
                                              textColor: blackColor,
                                              height: 4.h,
                                              ontap: () {},
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          Expanded(
                                            child: customButton(
                                              "Pay",
                                              color: ticketBlueColor,
                                              fontweight: FontWeight.w500,
                                              fontsize: 14.sp,
                                              textColor: whiteColor,
                                              height: 4.h,
                                              ontap: () {
                                                showTicketDialog(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Optional overlay inside ticket
                                Positioned(
                                  top: 12.9.h,
                                  right: 3.5.w,
                                  child: Image.asset(
                                    'assets/png/home_icons/line.png',
                                    height: 0.136.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 11.h, // 🔹 give it a fixed height
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // frosted effect
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 7.w, top: 4.h),
                    child: Row(
                      children: [
                        customText(
                          text: 'Tickets',
                          fontFamily: 'dmsans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.8.h,
                              ),
                              height: 4.h,
                              width: 8.5.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                                border: Border.all(
                                  color: textfieldBorderColor,
                                  width: 0.3.w,
                                ),
                              ),
                              child: Image.asset(
                                'assets/png/bell_icon.png',
                                width: 2.w,
                                height: 2.h,
                              ),
                            ),
                            Positioned(
                              right: 2.2.w,
                              top: 0.8.h,
                              child: Image.asset(
                                'assets/png/bell_icon2.png',
                                width: 1.6.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

// Row Widget
Widget rowWidget() {
  final DashboardController controller = Get.put(DashboardController());
  final List<String> options = ["Pending", "Approved", "Rejected"];

  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.sp),
        border: Border.all(
          color: textfieldBorderColor, // sirf yahan border
          width: 0.2.w,
        ),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final isSelected = controller.selectedIndex.value == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.selectedIndex.value = index;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.sp),
                    color: isSelected ? buttonPinkColor : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.2.h),
                  child: Center(
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ),
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

void showTicketDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor:
        Colors.transparent, // make barrier transparent (no default black dim)
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w), // reduce side padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.none,
          backgroundColor: Colors.transparent, // let TicketWidget control bg
          child: TicketWidget(
            width: double.infinity,
            height: 49.h,
            dyOffset: 15.h,
            isCornerRounded: true,
            color: whiteColor,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 🔹 QR code half inside, half outside
                Positioned(
                  top: -8.5.h, // adjust karke half andar half bahar kar lega
                  right: 0.w,
                  left: 0.w,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      clipBehavior: Clip.none,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: containerPinkColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/png/event_detail_icon/qrcode.png',
                          width: 18.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 9.5.h,
                  right: 0.w,
                  left: 0.w,
                  child: Image.asset(
                    'assets/png/home_icons/line.png',
                    height: 0.136.h,
                  ),
                ),Positioned(
                  top: 1.h,
                  right: 2.2.w,
                  child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.cancel, color: Colors.black.withOpacity(0.3),))
                ),

                // 🔹 Main content inside ticket
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👇 ye aapki Row aur Date/Ticket row as it is
                      SizedBox(height: 6.5.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.3.h),
                            child: customText(
                              text: 'Leadership Skills',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Padding(
                            padding: EdgeInsets.only(top: 0.6.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightPurple,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.5.w,
                                  vertical: 0.3.h,
                                ),
                                child: customText(
                                  text: "GBD998",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: darkPurpleColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 0.8.h),

                      // 🔹 Date & Tickets row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Date & Time
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 3.w,
                                top: 1.h,
                                bottom: 1.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: const Color(0xFFD9F3FB),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/png/event_detail_icon/date&time.png',
                                    width: 7.5.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customText(
                                          text: "10 Sep, 2025",
                                          fontFamily: 'dmsans',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        customText(
                                          text: "12:00 AM - 2:00 PM",
                                          fontFamily: 'dmsans',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),

                          // Tickets
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: const Color(0xFFFFE4F8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 3.w,
                                  top: 1.h,
                                  bottom: 1.h,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                        child: Image.asset(
                                          'assets/png/bottom_nav_icon/ticket.png',
                                          width: 5.w,
                                          color: buttonPinkColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                            text: "\$ 40",
                                            fontFamily: 'dmsans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          customText(
                                            text: "5 Tickets Purchase",
                                            fontFamily: 'dmsans',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.5.h),

                      // 🔹 Naya container niche
                      customText(
                        text: 'Location',
                        fontFamily: 'dmsans',
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp
                      ),
                      SizedBox(height: 0.6.h),
                      Container(
                        child: Image.asset('assets/png/home_icons/map.png'),
                      ),

                      SizedBox(height: 4.5.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/png/home_icons/barcode.png",
                            width: 12.h,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: customButton(
                              "Cancel  ",
                              color: ticketGreyColor,
                              fontweight: FontWeight.w500,
                              fontsize: 14.sp,
                              textColor: blackColor,
                              height: 4.h,
                              ontap: () {
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: customButton(
                              "Pay  ",
                              color: ticketBlueColor,
                              fontweight: FontWeight.w500,
                              fontsize: 14.sp,
                              textColor: whiteColor,
                              height: 4.h,
                              ontap: () {
                                showTicketDialog(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
