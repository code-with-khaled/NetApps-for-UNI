import 'package:flutter/material.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:network_apps/views/auth/auth_screen.dart';
import 'package:network_apps/views/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
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
          ),
        ),
      ),
      home: AuthScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/auth': (context) => AuthScreen(),
      },
    );
  }
}
