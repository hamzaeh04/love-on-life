import 'dart:async';
import 'package:get/get.dart';
import '../controllers/community_controller.dart';

class SearchController2 extends GetxController {
  var searchText = ''.obs;

  void updateSearch(String value) {
    searchText.value = value;
  }

  RxBool isSearch = false.obs;

  void toggleSearch() {
    isSearch.value = !isSearch.value;
  }

  // Filtered list based on search
  var filteredItems = <dynamic>[].obs;

  // Reference to CommunityController
  final CommunityController communityController = Get.find<CommunityController>();

  // Debounce timer
  Timer? _debounce;

  /// Call this on TextField onChanged
  void debounceSearch(String value, {int milliseconds = 500}) {
    // Cancel previous timer if it exists
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      // Update searchText observable so UI rebuilds
      searchText.value = value;

      if (value.isEmpty) {
        isSearch.value = false;
        filteredItems.clear();
        // Optional: fetch all events from backend
        await communityController.getAllEvents(
          search: '',
          category: '',
          page: 1,
          limit: 10,
          isLoadMore: false,
        );
      } else {
        isSearch.value = true;

        // Local filtering for instant UI update
        filteredItems.value = communityController.eventsList
            .where((event) =>
            (event.eventTitle ?? '')
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();

        // Optional: fetch filtered events from backend
        await communityController.getAllEvents(
          search: value,
          category: '',
          page: 1,
          limit: 10,
          isLoadMore: false,
        );
      }
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}