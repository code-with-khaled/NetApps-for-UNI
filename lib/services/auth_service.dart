import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_apps/utils/constants.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    print(response.data);

    if (response.statusCode == 200) {
      final token = response.data['token'];
      final userId = response.data["user_id"];
      await _storage.write(key: 'user_id', value: userId.toString());
      await _storage.write(key: 'auth_token', value: token);
      return true;
    } else {
      throw Exception('Failed to login');
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

  Future<bool> sendOtp(String otp) async {
    try {
      // ignore: unused_local_variable
      final token = await getAuthToken();
      final id = await getUserId();

      final response = await _dio.post('/verifyEmail/$id', data: {'otp': otp});

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<void> logout() async {
    // Implement logout logic if needed
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> clearAuthToken() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_id');
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }
}
