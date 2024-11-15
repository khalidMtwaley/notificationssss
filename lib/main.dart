import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notificationsssss/firebase_options.dart';
import 'package:notificationsssss/routes.dart';
import 'package:notificationsssss/services/local_notification_service.dart';
import 'package:notificationsssss/services/push_notification_services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.wait([PushNotificationServices.init(navigatorKey),  LocalNotificationService.init(navigatorKey)]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: MyHomePage.routeName,
      routes: AppRoutes.routes,
  
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 static const String routeName ="/home";



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text("title"),
      ),
      body: Center(
      
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
