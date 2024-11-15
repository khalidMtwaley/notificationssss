// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class NotificationsView extends StatelessWidget {
//   static const String routeName = '/notifications';
//   const NotificationsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notifications",style: TextStyle(color: Colors.amber),),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static const String routeName = '/notifications';

  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the notification
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Extract data from arguments
    final String? title = arguments?['title'] ?? 'No title';
    final String? body = arguments?['body'] ?? 'No body';
    final Map<String, dynamic>? data = arguments?['data'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details", style: TextStyle(color: Colors.amber)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: $title", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Body: $body", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            if (data != null) ...[
              const Text("Additional Data:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(data.toString(), style: const TextStyle(fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }
}
