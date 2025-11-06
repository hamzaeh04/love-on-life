import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedIndex = 0.obs;


  List<Map<String, String>> cards = [
    {"path": "assets/png/card_icons/visa.png", "no": "**** **** **** 2512"},
    {"path": "assets/png/card_icons/mastercard.png", "no": "**** **** **** 5421"},
    {"path": "assets/png/card_icons/gpay.png", "no": "**** **** **** 2512"},
  ];
}
