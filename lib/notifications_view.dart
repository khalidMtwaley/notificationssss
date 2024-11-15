import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationsView extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",style: TextStyle(color: Colors.amber),),
      ),
    );
  }
}