import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CalendarController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxList<DateTime> selectedDays = <DateTime>[].obs;

  void onDaySelected(DateTime day, DateTime focusedDayValue) {
    focusedDay.value = focusedDayValue;

    // Toggle selection — select or unselect a date
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  bool isSelected(DateTime day) {
    return selectedDays.any((d) =>
    d.year == day.year && d.month == day.month && d.day == day.day);
  }
}
