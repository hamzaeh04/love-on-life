import 'package:get/get.dart';

class DashboardController extends GetxController{
   RxInt discoverIndex = 0.obs;
   var selectedIndex = 0.obs;


   final List<String> discoverList = [
    "All",
    "Educational",
    "Music",
    "Buisness",
    "Motivational",
  ];
   final List<String> ticketList = [
     "Leadership skills",
     "Business Conference",
     "Album Release",
     "Future Consultation",
     "Youth Education"
   ];
   final List<String> options = ["Pending", "Approved", "Rejected"];

  void switchDiscoverTab(int index){
    discoverIndex.value = index;
  }
}
