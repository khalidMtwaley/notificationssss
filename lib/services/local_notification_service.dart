// // import 'dart:convert';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:http/http.dart' as http;

// // class LocalNotificationService {
// //   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   // Initialize the local notification service
// //   static Future<void> init() async {
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');

// //     const InitializationSettings initializationSettings =
// //         InitializationSettings(
// //       android: androidInitializationSettings,
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(
// //       initializationSettings,
// //       onDidReceiveNotificationResponse: (NotificationResponse response) {
// //         // Handle notification tap
// //         print("Notification tapped: ${response.payload}");
// //       },
// //     );
// //   }

// //   // Show a basic notification
// //   static Future<void> showBasicNotification(RemoteMessage message) async {
// //     final String? imageUrl = message.notification?.android?.imageUrl;

// //     BigPictureStyleInformation? bigPictureStyleInformation;
// //     if (imageUrl != null && imageUrl.isNotEmpty) {
// //       final http.Response response = await http.get(Uri.parse(imageUrl));
// //       bigPictureStyleInformation = BigPictureStyleInformation(
// //         ByteArrayAndroidBitmap.fromBase64String(
// //             base64Encode(response.bodyBytes)),
// //         largeIcon: ByteArrayAndroidBitmap.fromBase64String(
// //             base64Encode(response.bodyBytes)),
// //       );
// //     }

// //     AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails(
// //       'channel_id', // Channel ID
// //       'channel_name', // Channel Name
// //       importance: Importance.max,
// //       priority: Priority.high,
// //       styleInformation: bigPictureStyleInformation,
// //       icon: '@mipmap/ic_launcher',
// //     );

// //     NotificationDetails notificationDetails = NotificationDetails(
// //       android: androidNotificationDetails,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       message.messageId.hashCode,
// //       message.notification?.title,
// //       message.notification?.body,
// //       notificationDetails,
// //     );
// //   }
// // }
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print("Notification tapped: ${response.payload}");
//       },
//     );
//   }

//   static Future<void> showBasicNotification(RemoteMessage message) async {
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//       'channel_id', // Channel ID
//       'channel_name', // Channel Name
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       message.messageId.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       notificationDetails,
//     );
//   }
// }
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the local notification service
  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Navigate to NotificationsView when the notification is tapped
        log("Local notification tapped");
        navigatorKey.currentState?.pushNamed('/notifications');
      },
    );
  }

  // Show a basic notification with a payload
  static Future<void> showBasicNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id', // Channel ID
      'channel_name', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: 'NavigateToNotificationsView', // Payload to identify the action
    );
  }
}
