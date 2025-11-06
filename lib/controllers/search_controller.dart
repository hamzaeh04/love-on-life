import 'package:get/get.dart';

class SearchController2 extends GetxController{
  RxBool isSearch = false.obs;

  void toggleSearch(){
    isSearch == false ? isSearch.value = true : isSearch.value = false;
  }
}