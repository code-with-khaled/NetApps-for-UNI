import 'package:flutter/material.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:network_apps/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginBody({super.key, required this.onLoginSuccess});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State Variables
  bool obsecure = true;

  void showPassword() {
    setState(() {
      obsecure = !obsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome Back"),
          Text("Sign in to submit and track your complaints"),
          Text("Mobile Number or Email"),
          CustomTextField(
            prefixIcon: Icon(Icons.person),
            hintText: "number or email",
            controller: emailController,
          ),
          Text("Password"),
          CustomTextField(
            prefixIcon: Icon(Icons.lock),
            hintText: "password",
            suffix: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {
                  showPassword();
                },
                icon: obsecure
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.grey.shade600,
                      )
                    : Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.grey.shade600,
                      ),
              ),
            ),
            obsecure: obsecure,
            controller: passwordController,
          ),

          ElevatedButton(
            onPressed: () {
              // authVM.login(emailController.text, passwordController.text);
              widget.onLoginSuccess();
            },
            child: Text("Login"),
          ),
          if (authVM.errorMessage != null)
            Text(authVM.errorMessage!, style: TextStyle(color: Colors.red)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("OR"),
              ),
              Expanded(child: Divider()),
            ],
          ),

          ElevatedButton(
            onPressed: () {
              // authVM.signUp(emailController.text, passwordController.text);

              widget.onLoginSuccess();
            },
            child: Text("Sign Up"),
          ),

          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.security),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Secure Login"),
                    Text("Your credentials are safe with us"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
