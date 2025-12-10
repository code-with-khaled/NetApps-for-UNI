import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_apps/utils/constants.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    // ignore: avoid_print
    print(response.data);

    if (response.statusCode == 200) {
      final token = response.data['token'];
      final userId = response.data["user_id"];
      await _storage.write(key: 'auth_token', value: token);
      await _storage.write(key: 'user_id', value: userId.toString());

      return true;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    final response = await _dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmedPassword,
      },
    );

    if (response.statusCode == 201) {
      final token = response.data['token'];
      final userId = response.data['user_id'];
      await _storage.write(key: "auth_token", value: token);
      await _storage.write(key: "user_id", value: userId.toString());

      return true;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<bool> sendOtp(String otp) async {
    try {
      final id = await getUserId();

      final response = await _dio.post('/verifyEmail/$id', data: {'code': otp});

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<bool> logout() async {
    final token = await getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final response = await _dio.post(
      '/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      await clearAuthToken();
      return true;
    } else {
      throw Exception('Failed to logout');
    }
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
