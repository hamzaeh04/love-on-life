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

  void addTicketToLocalList(Tickets newTicket) {
    if (getTicketModel.value?.data?.tickets != null) {
      // Insert at the top (index 0) so the user sees it immediately
      getTicketModel.value!.data!.tickets!.insert(0, newTicket);

      // 🔹 Crucial: Refresh the Rx object to trigger UI update
      getTicketModel.refresh();
    } else {
      // If the list was null, trigger a full fetch
      getTickets(page: 1, limit: 10, status: 'pending');
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    if (ticketId.isEmpty) return;

    // 1️⃣ BACKUP: Find the ticket and its index before removing
    final tickets = getTicketModel.value?.data?.tickets;
    if (tickets == null) return;

    final int index = tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return;

    final backupTicket = tickets[index];

    try {
      // 2️⃣ OPTIMISTIC UPDATE: Remove instantly from local list
      tickets.removeAt(index);
      getTicketModel.refresh(); // Force UI update

      // 3️⃣ SILENT API CALL
      final String url = ApiEndPoints.deleteTicket(ticketId);
      final responseData = await baseService.baseDeleteAPI(url);

      if (responseData != null && responseData["success"] == true) {
        // Success: Optional toast
        Utils.showToast(responseData["message"] ?? "Ticket deleted", false);
      } else {
        // 4️⃣ ROLLBACK: If API fails, put the ticket back
        tickets.insert(index, backupTicket);
        getTicketModel.refresh();
        Utils.showToast(responseData?["message"] ?? "Failed to delete ticket", true);
      }
    } catch (e) {
      // 4️⃣ ROLLBACK: If app crashes/timeouts
      tickets.insert(index, backupTicket);
      getTicketModel.refresh();
      debugPrint("❌ Delete Error: $e");
      Utils.showToast("Connection error", true);
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