import 'package:flutter/material.dart';
import 'package:network_apps/utils/authmode.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:network_apps/viewmodels/submit_complaint_viewmodel.dart';
import 'package:network_apps/views/auth/auth_screen.dart';
import 'package:network_apps/views/auth/register_screen.dart';
import 'package:network_apps/views/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
