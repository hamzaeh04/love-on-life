import 'package:get/get.dart';
import 'package:love_on_life/core/services/notification/notification_service.dart';

class NotificatonController extends GetxController{
  FirebaseNotification firebaseApi = FirebaseNotification();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firebaseApi.onTokenRefresh();
    firebaseApi.firebaseInIt();
    // firebaseApi.getTokenForApi();
  }
}
