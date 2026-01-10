import 'package:flutter/material.dart';
import 'package:network_apps/models/app_notification.dart';
import 'package:network_apps/services/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationService _service = NotificationService();
  String? _latestToken;
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;

  void setLatestToken(String token) {
    _latestToken = token;
  }

  Future<void> sendToken() async {
    print("Sending token from ViewModel");
    if (_latestToken == null) return;
    await _service.sendDeviceToken(_latestToken!);
  }

  void addNotification(String title, String body) {
    _notifications.insert(
      0,
      AppNotification(title: title, body: body, timestamp: DateTime.now()),
    );
    notifyListeners();
  }
}
