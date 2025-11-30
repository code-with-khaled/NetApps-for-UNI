import 'package:flutter/material.dart';
import 'package:network_apps/views/auth/login_body.dart';
import 'package:network_apps/views/auth/otp_body.dart';

enum AuthMode { login, otp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode authMode = AuthMode.login;

  void goToOtp() {
    setState(() {
      authMode = AuthMode.otp;
    });
  }

  void backToLogin() {
    setState(() {
      authMode = AuthMode.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.deepPurple.shade400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 24),
                    Icon(Icons.location_city, size: 60, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      "Government Complaints",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Voice, Our Priority",
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: authMode == AuthMode.login
                ? LoginBody(onLoginSuccess: goToOtp)
                : OtpScreen(onBackToLogin: backToLogin),
          ),
        ],
      ),
    );
  }
}
