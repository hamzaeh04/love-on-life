import 'dart:async';

import 'package:get/get.dart';
import '../controllers/community_controller.dart';

class SearchController2 extends GetxController {
  RxBool isSearch = false.obs;

  void toggleSearch() {
    isSearch.value = !isSearch.value;
  }

  // Filtered list based on search
  var filteredItems = <dynamic>[].obs;

  // Reference to CommunityController
  final CommunityController communityController = Get.find<CommunityController>();

  // Called on text change
  void search(String query) {
    final allEvents = communityController.eventsList;

    if (query.isEmpty) {
      filteredItems.clear();
    } else {
      filteredItems.value = allEvents
          .where((event) =>
          (event.eventTitle ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }
  Timer? _debounce;

  void debounceSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () async {
      final communityController = Get.find<CommunityController>();
      if (value.isEmpty) {
        await communityController.getAllEvents(search: '', category: '', page: 1, limit: 10, isLoadMore: false);
      } else {
        await communityController.getAllEvents(search: value, category: '', page: 1, limit: 10, isLoadMore: false);
      }
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

}
