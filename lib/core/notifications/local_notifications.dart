import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationService {
  static StreamController<ReceivedAction> streamController = StreamController();

  // تهيئة المكتبة + إنشاء القناة
  static Future init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic notifications',
          importance: NotificationImportance.Max,
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
        ),
      ],
      debug: true,
    );

    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    // ربط الـ listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  // عرض إشعار بسيط
  static Future<void> showBasicNotification(RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        notificationLayout: NotificationLayout.Default,
        payload: message.data.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      ),
    );
  }
}

// ✅ لازم تكون Global و Static ومضاف عليها pragma
@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction action) async {
  AwesomeNotificationService.streamController.add(action);
}
