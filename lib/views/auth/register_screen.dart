import 'package:flutter/material.dart';
import 'package:network_apps/utils/authmode.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:network_apps/views/auth/auth_screen.dart';
import 'package:network_apps/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // State Variables
  bool obsecure = true;

  void showPassword() {
    setState(() {
      obsecure = !obsecure;
    });
  }

  void verifyEmail() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => AuthScreen(initialMode: AuthMode.otp)),
    );
  }

  void showError(String? errorMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Min 8 chars, at least 1 letter + 1 number
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 4),

                    Text(
                      "Sign in to submit and track your complaints",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      prefixIcon: Icon(Icons.person),
                      hintText: "enter your name",
                      controller: nameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 12),

                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      prefixIcon: Icon(Icons.person),
                      hintText: "enter your email",
                      controller: emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Email is required";
                        }
                        if (!isValidEmail(val.trim())) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),

                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
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
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Password is required";
                        }
                        if (!isValidPassword(val)) {
                          return "Min 8 chars, include letters & numbers";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),

                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "re-enter your password",
                      obsecure: true,
                      controller: confirmPasswordController,
                      validator: (val) => val == null || val.isEmpty
                          ? "Required"
                          : val != passwordController.text
                          ? "Passwords don't match"
                          : null,
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (authVM.isLoading) return;

                                bool success = await authVM.register(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  confirmPasswordController.text,
                                );

                                if (!success) {
                                  showError(authVM.errorMessage);
                                }

                                if (success && mounted) {
                                  verifyEmail();
                                }
                              }
                            },
                            child: authVM.isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text("Create Account"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Login
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/auth');
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.resolveWith(
                                (states) => Colors.deepPurple,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.all(2),
                              ),
                              minimumSize: WidgetStateProperty.all(
                                const Size(0, 0),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text("Login Here"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.deepPurple.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.security),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Secure Register",
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
            ),
          ),
        ],
      ),
    );
  }
}
