import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:love_on_life/core/services/apiendpoints.dart';
import 'package:love_on_life/core/services/base_services.dart';

class StripeController extends GetxController {
  final BaseService baseService = BaseService();
  var isLoading = false.obs;

  /// Create PaymentIntent on backend
  Future<Map<String, dynamic>> createPaymentIntent({
    required String ticketId,
  }) async {
    final body = {"ticketId": ticketId};

    final response = await baseService.basePostAPI(
      ApiEndPoints.createPaymentIntent,
      body,
    );

    if (response == null) throw Exception("No response from server");
    print("PAYMENT INTENT RESPONSE: $response");
    if (response['success'] != true) {
      throw Exception(response['message'] ?? response['error'] ?? "Payment intent creation failed. Full response: $response");
    }

    final data = response['data'];
    if (data == null || data['clientSecret'] == null) {
      throw Exception("Client secret not received from backend");
    }

    return data;
  }

  /// Initialize & Present PaymentSheet
  Future<void> startPayment({required String ticketId}) async {
    try {
      isLoading.value = true;

      // Get clientSecret from backend
      final data = await createPaymentIntent(ticketId: ticketId);
      final clientSecret = data['clientSecret'] as String;
      final amount = data['amount'];
      final currency = data['currency'];

      print("Payment Amount: $amount $currency");

      // Initialize PaymentSheet (flutter_stripe 11.5.0)
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret, // REQUIRED
          merchantDisplayName: "Love On Life",
        ),
      );

      // Present PaymentSheet
      await Stripe.instance.presentPaymentSheet();

      print("Payment completed: $amount $currency");
    } on StripeException catch (e) {
      print("Payment cancelled: ${e.error.localizedMessage}");
    } catch (e) {
      print("Payment error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
