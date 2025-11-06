import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendar_controller.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 👇 Header
        Obx(() => Row(
          children: [
            customText(
              text:
              '  ${_monthName(controller.focusedDay.value.month)} ${controller.focusedDay.value.year}',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  size: 14.sp, weight: 600),
              onPressed: () {
                controller.focusedDay.value = DateTime(
                  controller.focusedDay.value.year,
                  controller.focusedDay.value.month - 1,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  size: 14.sp, weight: 600),
              onPressed: () {
                controller.focusedDay.value = DateTime(
                  controller.focusedDay.value.year,
                  controller.focusedDay.value.month + 1,
                );
              },
            ),
          ],
        )),

        SizedBox(height: 0.5.h),

        // 👇 Stack wraps the calendar + divider
        Obx(
              () => Stack(
            children: [
              TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: controller.focusedDay.value,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerVisible: false,

                // Adjust row/label heights
                rowHeight: 4.4.h,
                daysOfWeekHeight: 3.5.h, // 👈 More space below weekday labels

                // Calendar Styling
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: false,
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF16A34A).withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),

                  // 👇 Font family for dates
                  defaultTextStyle: TextStyle(
                    fontFamily: 'dmsans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.5.sp,
                    color: Colors.black,
                  ),
                  weekendTextStyle: TextStyle(
                    fontFamily: 'dmsans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  selectedTextStyle: TextStyle(
                    fontFamily: 'dmsans',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),

                // Weekday labels (Sun, Mon, ...)
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontFamily: 'dmsans',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                  weekendStyle: TextStyle(
                    fontFamily: 'dmsans',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                ),

                selectedDayPredicate: (day) => controller.isSelected(day),
                onDaySelected: controller.onDaySelected,
              ),

              // 👇 Divider placed right under weekday labels
              Positioned(
                top: 2.8.h, // 👈 moved down to be under "Sun Mon Tue..."
                left: 2.w,
                right: 2.w,
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 0.1.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h,),
        InkWell(
            onTap: (){
              Get.back();
            },
            child: Image.asset('assets/png/community_icon/cancel.png', width: 60.w, height: 2.5.h,)),
        SizedBox(height: 2.h,),
      ],
    );
  }
}

String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}
