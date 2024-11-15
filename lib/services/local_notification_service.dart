// // // import 'dart:convert';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:http/http.dart' as http;

// // // class LocalNotificationService {
// // //   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // //       FlutterLocalNotificationsPlugin();

// // //   // Initialize the local notification service
// // //   static Future<void> init() async {
// // //     const AndroidInitializationSettings androidInitializationSettings =
// // //         AndroidInitializationSettings('@mipmap/ic_launcher');

// // //     const InitializationSettings initializationSettings =
// // //         InitializationSettings(
// // //       android: androidInitializationSettings,
// // //     );

// // //     await flutterLocalNotificationsPlugin.initialize(
// // //       initializationSettings,
// // //       onDidReceiveNotificationResponse: (NotificationResponse response) {
// // //         // Handle notification tap
// // //         print("Notification tapped: ${response.payload}");
// // //       },
// // //     );
// // //   }

// // //   // Show a basic notification
// // //   static Future<void> showBasicNotification(RemoteMessage message) async {
// // //     final String? imageUrl = message.notification?.android?.imageUrl;

// // //     BigPictureStyleInformation? bigPictureStyleInformation;
// // //     if (imageUrl != null && imageUrl.isNotEmpty) {
// // //       final http.Response response = await http.get(Uri.parse(imageUrl));
// // //       bigPictureStyleInformation = BigPictureStyleInformation(
// // //         ByteArrayAndroidBitmap.fromBase64String(
// // //             base64Encode(response.bodyBytes)),
// // //         largeIcon: ByteArrayAndroidBitmap.fromBase64String(
// // //             base64Encode(response.bodyBytes)),
// // //       );
// // //     }

// // //     AndroidNotificationDetails androidNotificationDetails =
// // //         AndroidNotificationDetails(
// // //       'channel_id', // Channel ID
// // //       'channel_name', // Channel Name
// // //       importance: Importance.max,
// // //       priority: Priority.high,
// // //       styleInformation: bigPictureStyleInformation,
// // //       icon: '@mipmap/ic_launcher',
// // //     );

// // //     NotificationDetails notificationDetails = NotificationDetails(
// // //       android: androidNotificationDetails,
// // //     );

// // //     await flutterLocalNotificationsPlugin.show(
// // //       message.messageId.hashCode,
// // //       message.notification?.title,
// // //       message.notification?.body,
// // //       notificationDetails,
// // //     );
// // //   }
// // // }
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';

// // class LocalNotificationService {
// //   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   static Future<void> init() async {
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');

// //     const InitializationSettings initializationSettings = InitializationSettings(
// //       android: androidInitializationSettings,
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(
// //       initializationSettings,
// //       onDidReceiveNotificationResponse: (NotificationResponse response) {
// //         print("Notification tapped: ${response.payload}");
// //       },
// //     );
// //   }

// //   static Future<void> showBasicNotification(RemoteMessage message) async {
// //     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
// //       'channel_id', // Channel ID
// //       'channel_name', // Channel Name
// //       importance: Importance.max,
// //       priority: Priority.high,
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
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:developer';

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize the local notification service
//   static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Navigate to NotificationsView when the notification is tapped
//         log("Local notification tapped");
//         navigatorKey.currentState?.pushNamed('/notifications',arguments: response.payload);
//       },
//     );
//   }

//   // Show a basic notification with a payload
//   static Future<void> showBasicNotification(RemoteMessage message) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
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
//       payload: message.notification!.body, // Payload to identify the action
//     );
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes the local notification service
  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("Local notification tapped with payload: ${response.payload}");
        if (response.payload != null) {
          final Map<String, dynamic> payloadData = jsonDecode(response.payload!);
          navigatorKey.currentState?.pushNamed(
            '/notifications',
            arguments: payloadData,
            /*This payload (payloadData) is extracted when the user taps on a notification.
It comes from the payload that was passed when the notification was displayed (during showBasicNotification).
It is used for navigation purposes, typically passing data to the NotificationsView. */
          );
        }
      },
    );
  }

  /// Displays a basic notification with a payload
  static Future<void> showBasicNotification(RemoteMessage message) async {
    // Prepare notification details
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channel_id', 
      'channel_name', 
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Encode payload as JSON
    //this payload also
    final String payload = jsonEncode({
      'title': message.notification?.title ?? 'No title',
      'body': message.notification?.body ?? 'No body',
      'data': message.data, 
      
      /* for example, if the message data is:
       {
  "title": "New Message",
  "body": "You have a new message!",
  "data": {
    "messageId": "12345",
    "senderName": "John Doe",
    "priority": "high"
  }
}
This payload is prepared when showing the notification.
It encodes the message data into a JSON string.

Anything you want to show in the Notification View when the user 
taps the notification must be included in the payload of the
 flutterLocalNotificationsPlugin.show() method. This is because
  the payload is the primary way to pass data from the notification to your app when it is tapped.
 */
    });

    // Display the notification
    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,   // Unique ID for the notification
      message.notification?.title, 
      message.notification?.body,  
      notificationDetails,
      payload: payload,            // Pass payload for navigation
    );
  }

  /// Cancels all notifications (optional utility method)
  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
