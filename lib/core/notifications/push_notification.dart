import 'dart:developer';
import 'package:camion/core/notifications/local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future init() async {
    Future.wait([
      messaging.requestPermission(),
      AwesomeNotificationService.init(),
    ]);

    token = await messaging.getToken();
    if (token != null) {
      log('FCM Token: $token');
    } else {
      log('Failed to get FCM Token');
    }
  }

  static Future handleNotifications() async {
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    handleForegroundMessage();

    messaging.subscribeToTopic('all').then((_) {
      log('Subscribed to topic');
    });
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log('BG Message: ${message.notification?.title ?? 'null'}');
    await AwesomeNotificationService.showBasicNotification(message);
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotificationService.showBasicNotification(message);
    });
  }
}
