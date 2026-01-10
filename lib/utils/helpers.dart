import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  static Color getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue.shade100;
      case 'in progress':
        return Colors.orange.shade100;
      case 'resolved':
        return Colors.green.shade100;
      default:
        return Colors.red.shade100;
    }
  }

  static IconData getFileIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_sharp;
      case 'jpg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  static Color getFileIconColor(String? fileType) {
    switch (fileType?.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static Future<String?> getAuthToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: 'auth_token');
  }

  static Future<void> clearAuthToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'user_id');
  }

  static Future<String?> getUserId() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: 'user_id');
  }

  static String extractFileName(String path) {
    return path.split('/').last;
  }
}
