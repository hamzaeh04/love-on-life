import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/model/get_ticket_model.dart';

import '../core/services/apiendpoints.dart';
import '../utils/utility.dart';

class TicketController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isFetchingMore = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxString currentStatus = 'pending'.obs;

  Rx<GetTicketModel?> getTicketModel = Rx<GetTicketModel?>(null);
  ScrollController scrollController = ScrollController();
  final BaseService baseService = BaseService();

  void resetPagination() {
    currentPage.value = 1;
    getTicketModel.value = null;
  }

  Future<void> deleteTicket(String postId) async {
    if (postId.isEmpty) {
      Utils.showToast("Invalid post ID", true);
      return;
    }

    try {
      //isLoading.value = true;

      // Construct the DELETE endpoint URL
      final String url = ApiEndPoints.deleteTicket(postId);
      print("DELETE URL: $url");

      // Call the DELETE API
      final responseData = await baseService.baseDeleteAPI(url);

      print("Response: $responseData");

      if (responseData == null) {
        Utils.showToast("No response from server", true);
        return;
      }

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // Show success message
      Utils.showToast(responseData["message"] ?? "Ticket deleted successfully", false);

      // Remove the post from the local list if exists
      //getTicketModel.value?.data?.removeWhere((post) => post.id == postId);

      // Trigger UI update
      getTicketModel.refresh();

    } catch (e, stackTrace) {
      print("❌ Delete Ticket Error: $e\n$stackTrace");
      Utils.showToast("Unexpected error occurred", true);
    }
  }


  // @override
  // void onInit() {
  //   super.onInit();
  //   getTickets(
  //     page: 1,
  //     limit: 10,
  //     status: 'pending',
  //   );
  // }


  Future<GetTicketModel?> getTickets({int? page, int? limit, String? status,}) async {
    try {
      isLoading.value = true;
      currentStatus.value = status!;

      final response = await baseService.baseGetAPI(
        ApiEndPoints.getTickets(page!, limit!, status!,),
      );

      final responseData = response['data'];
      print(responseData);

      if (response['statusCode'] == 200) {
        final model = GetTicketModel.fromJson(response);
        //getTicketModel.value = model;
        totalPages.value = model.data?.totalPages ?? 1;

        if (page == 1) {
          getTicketModel.value = model;
        } else {
          getTicketModel.value?.data?.tickets
              ?.addAll(model.data?.tickets ?? []);
          getTicketModel.refresh();
        }

        currentPage.value = page;

        print("message: ${response['message']}");
      } else {
        debugPrint('Get tickets failed: ${response[
          'statusCode'
        ]}');
        return null;
      }
    } catch (e) {
      debugPrint("Ticket Error: $e");
    } finally {
      isLoading.value = false;
    }
  }





}