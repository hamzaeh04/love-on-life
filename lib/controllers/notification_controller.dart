import 'dart:io';

import 'package:get/get.dart';
import 'package:love_on_life/core/services/apiendpoints.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/core/services/notification/notification_service.dart';
import 'package:love_on_life/model/get_notification_model.dart';
class NotificationController extends GetxController {
  BaseService baseService = BaseService();
  FirebaseNotification firebaseApi = FirebaseNotification();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Platform.isAndroid || Platform.isIOS){
      firebaseApi.onTokenRefresh();
      firebaseApi.firebaseInIt();
    }
    // firebaseApi.getTokenForApi();
  }
  var getNotificationsModel = Rx<GetNotificationsModel?>(null);
  var notificationsList = <NotificationItem>[].obs; // cumulative list
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1;
  var totalPages = 1;

  var selectedFilter = 'All'.obs; // Filter: All / Read / Unread

  // Fetch notifications (initial or paginated)
  Future<void> GetNotification({int page = 1, int limit = 10}) async {
    if (page > totalPages) return; // stop if no more pages

    if (page == 1) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getNotifications(page, limit),
      );

      if (response['success'] == true) {
        final model = GetNotificationsModel.fromJson(response);

        totalPages = model.data?.pagination?.totalPages ?? 1;
        currentPage = model.data?.pagination?.page ?? 1;

        if (page == 1) {
          notificationsList.value = model.data?.notifications ?? [];
        } else {
          notificationsList.addAll(model.data?.notifications ?? []);
        }

        getNotificationsModel.value = model;
      }
    } catch (e) {
      print("GetNotifications Error: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // Apply filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
    GetNotification(page: 1, limit: 10); // reload from page 1 with filter
  }

  // Load next page
  Future<void> loadMore() async {
    if (!isLoadingMore.value && currentPage < totalPages) {
      await GetNotification(page: currentPage + 1, limit: 10);
    }
  }

  // Mark single notification as read
  void ReadSingleNotification(String id) {
    final index = notificationsList.indexWhere((n) => n.id == id);
    if (index != -1) {
      notificationsList[index].isRead = true;
      notificationsList.refresh();
    }
  }

  // Mark all as read
  void readAllNotifications() {
    for (var n in notificationsList) {
      n.isRead = true;
    }
    notificationsList.refresh();
  }
}