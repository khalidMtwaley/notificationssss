
// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:notificationsssss/services/local_notification_service.dart';

// class PushNotificationServices {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   static Future<void> init() async {
//     // Request permissions for notifications
//     await messaging.requestPermission();

//     // Get the FCM token
//     String? token = await messaging.getToken();
//     log("FCM Token: $token");

//     // Send the token to the server (if needed)
//     await messaging.getToken().then((value) {
//       if (value != null) sendTokenToServer(value);
//     });
//     messaging.onTokenRefresh.listen((value) => sendTokenToServer(value));

//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

//     // Handle foreground messages
//     _handleForegroundMessage();

//     // Subscribe to a topic (optional)
//     await messaging.subscribeToTopic('all').then((val) => log('Subscribed to topic: all'));
//   }

//   // Background message handler
//   static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     log("Background message received: ${message.notification?.title}");
//   }

//   // Foreground message handler
//   static void _handleForegroundMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("Foreground message received: ${message.notification?.title}");
//       if (message.notification != null) {
//         // Show the notification using LocalNotificationService
//         LocalNotificationService.showBasicNotification(message);
//       }
//     });
//   }

//   // Send the token to the server (dummy function)
//   static void sendTokenToServer(String token) {
//     log("Token sent to server: $token");
//   }
// }
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notificationsssss/services/local_notification_service.dart';

class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    // Request permissions for notifications
    await messaging.requestPermission();

    // Get the FCM token
    String? token = await messaging.getToken();
    log("FCM Token: $token");

    // Send the token to the server
    messaging.onTokenRefresh.listen((value) => sendTokenToServer(value));

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    // Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Foreground notification received: ${message.notification?.title}");
      if (message.notification != null) {
        LocalNotificationService.showBasicNotification(message);
      }
    });

    // Background and foreground taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification tapped while in background or foreground.");
      _onTapNotification(navigatorKey);
    });

    // Handle app launch from terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      log("App launched by notification: ${initialMessage.notification?.title}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onTapNotification(navigatorKey);
      });
    }
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("Background message received: ${message.notification?.title}");
  }

  static void _onTapNotification(GlobalKey<NavigatorState> navigatorKey) {
    log("Navigating to NotificationsView...");
    navigatorKey.currentState?.pushNamed('/notifications');
  }

  static void sendTokenToServer(String token) {
    log("Token sent to server: $token");
  }
}
