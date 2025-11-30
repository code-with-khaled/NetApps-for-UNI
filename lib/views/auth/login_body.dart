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
  final _formKey = GlobalKey<FormState>();

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

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            ),
            SizedBox(height: 4),

            Text(
              "Sign in to submit and track your complaints",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),

            Text(
              "Mobile Number or Email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            CustomTextField(
              prefixIcon: Icon(Icons.person),
              hintText: "number or email",
              controller: emailController,
              validator: (val) =>
                  val == null || val.isEmpty ? "Required" : null,
            ),
            SizedBox(height: 8),

            Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
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
              validator: (val) =>
                  val == null || val.isEmpty ? "Required" : null,
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // authVM.login(emailController.text, passwordController.text);
                      if (_formKey.currentState!.validate()) {
                        widget.onLoginSuccess();
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

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
            SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // authVM.signUp(emailController.text, passwordController.text);
                      if (_formKey.currentState!.validate()) {
                        widget.onLoginSuccess();
                      }
                    },
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            Container(
              padding: EdgeInsets.all(16),
              color: Colors.deepPurple.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.security),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Secure Login",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Your credentials are safe with us",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
