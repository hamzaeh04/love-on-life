import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? FCMToken;

  Future<void> initLocalNotification() async {
    var androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        print("Notification Received: $payload");
      },
    );
  }

  Future<void> firebaseInIt() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Message Title: ${message.notification!.title}");
        print("Message Body: ${message.notification!.body}");
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          "high_importance_channel",
          "High Importance Notification",
          importance: Importance.max,
        );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: "Your Channel Description",
          importance: Importance.high,
          priority: Priority.high,
          ticker: "ticker",
          icon: '@mipmap/ic_launcher',
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }
 Future<void> initNotification() async{
    await messaging.requestPermission();
    FCMToken = await messaging.getToken();
    print("Initial Token: $FCMToken");
 }
  void onTokenRefresh() {
    messaging.onTokenRefresh.listen((newToken) {
      FCMToken = newToken;
      print("Token refreshed: $FCMToken");
    });
  }

}
