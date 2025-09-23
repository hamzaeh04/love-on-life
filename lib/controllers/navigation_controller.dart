import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController{
var currentIndex = 0.obs;
PageController? _pageController;



void setPageController (PageController controller){
  _pageController = controller;
}
void changePage(int index) {
  currentIndex.value = index;
  if (_pageController?.hasClients ?? false) {
    _pageController!.jumpToPage(index);
  } else {
    debugPrint("⚠️ PageController not set or not attached");
  }
}
void goToHome() {
  if (currentIndex.value > 0) {
    changePage(0);
  }
}

void backPage() {
  if (_pageController?.hasClients ?? false && currentIndex.value > 0) {
    int previousIndex = currentIndex.value - 1;
    currentIndex.value = previousIndex;
    _pageController!.jumpToPage(previousIndex);
  }
}

}
