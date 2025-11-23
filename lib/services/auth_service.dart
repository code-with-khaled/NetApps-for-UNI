import 'package:dio/dio.dart';
import 'package:network_apps/utils/constants.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<void> login(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'username': email, 'password': password},
    );

    if (response.statusCode == 200) {
      // Handle successful login
    } else {
      // Handle login error
    }
  }

  Future<void> signUp(String email, String password) async {
    final response = await _dio.post(
      '/signup',
      data: {'username': email, 'password': password},
    );

    if (response.statusCode == 201) {
      // Handle successful signup
    } else {
      // Handle signup error
    }
  }

  Future<void> sendOtp(String otp) async {
    final response = await _dio.post('/verify-otp', data: {'otp': otp});

    if (response.statusCode == 200) {
      // Handle successful OTP verification
    } else {
      // Handle OTP verification error
    }
  }

  Future<void> logout() async {
    // Implement logout logic if needed
  }
}
