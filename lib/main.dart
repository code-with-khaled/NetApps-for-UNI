import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:network_apps/utils/authmode.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:network_apps/viewmodels/submit_complaint_viewmodel.dart';
import 'package:network_apps/views/auth/auth_screen.dart';
import 'package:network_apps/views/auth/register_screen.dart';
import 'package:network_apps/views/home/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => SubmitComplaintViewModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  // Request notification permissions, get FCM token and listen to messages
  Future<void> _initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // ignore: avoid_print
    print("Permission: ${settings.authorizationStatus}");

    // Get FCM token
    String? token = await messaging.getToken();

    // ignore: avoid_print
    print("FCM Token: $token");

    // TODO: send token to your backend

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Foreground message: ${message.notification?.title}');
      if (message.notification != null) {
        // ignore: avoid_print
        print('Data: ${message.notification}');
      }
    });

    // When the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Notification opened: ${message.data}');
    });

    // When app is opened from terminated state
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      // ignore: avoid_print
      print("Opened from terminated state: ${initialMessage.data}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(6),
                side: BorderSide.none,
              ),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ),
      ),
      home: AuthScreen(initialMode: AuthMode.login),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/auth': (context) => AuthScreen(initialMode: AuthMode.login),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
