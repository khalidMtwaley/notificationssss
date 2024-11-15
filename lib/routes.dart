
import 'package:flutter/widgets.dart';
import 'package:notificationsssss/main.dart';
import 'package:notificationsssss/notifications_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    MyHomePage.routeName: (context) => const MyHomePage(),
    NotificationsView.routeName: (context) => const NotificationsView(),
 
    
  };
}
