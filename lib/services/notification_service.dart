// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:network_apps/utils/constants.dart';
import 'package:network_apps/utils/helpers.dart';

class NotificationService {
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

  Future<void> sendDeviceToken(String token) async {
    print("Sending token from Service");

    final userId = await Helpers.getUserId();
    final authToken = await Helpers.getAuthToken();

    if (userId == null || authToken == null) {
      print("User not logged in — skipping token send");
      return;
    }

    try {
      final response = await _dio.post(
        '/fcm/token',
        data: {"token": token},
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );

      print("Token sent to backend: ${response.statusCode}");
    } catch (e) {
      print("Error sending token: $e");
    }
  }
}
