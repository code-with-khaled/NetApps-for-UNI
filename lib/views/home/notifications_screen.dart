import 'package:flutter/material.dart';
import 'package:network_apps/viewmodels/notification_viewmodel.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(
      builder: (context, vm, _) {
        if (vm.notifications.isEmpty) {
          return const Center(child: Text('No notifications yet.'));
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final notification = vm.notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(
                '${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}',
              ),
            );
          },
          itemCount: vm.notifications.length,
        );
      },
    );
  }
}
