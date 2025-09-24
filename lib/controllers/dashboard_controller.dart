import 'package:get/get.dart';

class DashboardController extends GetxController{
   RxInt discoverIndex = 0.obs;


  final List<String> discoverList = [
    "All",
    "Educational",
    "Music",
    "Buisness",
    "Motivational",
  ];

  void switchDiscoverTab(int index){
    discoverIndex.value = index;
  }
}
