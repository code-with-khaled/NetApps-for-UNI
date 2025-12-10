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
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.register(
        name,
        email,
        password,
        confirmedPassword,
      );

      if (!success) {
        _errorMessage = null;
      }

      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
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
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.logout();

      if (!success) {
        _errorMessage = "Logout failed";
      }

      return success;
    } catch (e) {
      _errorMessage = "Somthing went wrong";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
