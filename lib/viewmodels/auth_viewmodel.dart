import 'package:flutter/material.dart';
import 'package:network_apps/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.login(email, password);

      if (!success) {
        _errorMessage = "Login failed";
      }

      return success;
    } catch (e) {
      _errorMessage = "Something went wrong";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signUp(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.sendOtp(otp);

      if (!success) {
        _errorMessage = "OTP verification failed";
      }

      return success;
    } catch (e) {
      _errorMessage = "Something went wrong";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
