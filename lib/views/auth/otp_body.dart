// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final VoidCallback onBackToLogin;

  const OtpScreen({super.key, required this.onBackToLogin});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  Timer? _timer;
  int remainingSeconds = 120;

  String getOtp() {
    return controllers.map((c) => c.text).join();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer([int seconds = 300]) {
    _timer?.cancel();
    setState(() {
      remainingSeconds = seconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          remainingSeconds = 0;
        });
      } else {
        setState(() {
          remainingSeconds -= 1;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get _canResend => remainingSeconds == 0;

  void _resendOtp() {
    // TODO: implement actual resend logic (API call)
    _startTimer();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP resent')));
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authVM = Provider.of<AuthViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: widget.onBackToLogin,
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Back to login'),
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Verify OTP",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Enter the 6-digit code sent to your mobile"),
            const SizedBox(height: 24),

            // OTP fields row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  height: 68,
                  width: 48,
                  child: TextField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 32),

            // Verify button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final c = context;
                      final otp = getOtp();
                      final success = await authVM.sendOtp(otp);

                      if (!mounted) return;

                      if (success) {
                        Navigator.pushReplacementNamed(c, '/home');
                      } else {
                        ScaffoldMessenger.of(c).showSnackBar(
                          const SnackBar(content: Text('Invalid OTP')),
                        );
                      }
                    },
                    child: const Text("Verify & Continue"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Resend link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive code? "),
                TextButton(
                  onPressed: _canResend ? _resendOtp : null,
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.resolveWith(
                      (states) => _canResend ? Colors.deepPurple : Colors.grey,
                    ),
                    padding: WidgetStateProperty.all(EdgeInsets.all(2)),
                    minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text("Resend OTP"),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Countdown
            Text(
              "OTP expires in ${_formatTime(remainingSeconds)}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
