import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    const androisInitialize =
        AndroidInitializationSettings("mipmap/ic_launcher");
    const initializeSettings =
        InitializationSettings(android: androisInitialize);
    await _notifications.initialize(initializeSettings);
  }

  static Future _notificationDetails() async => const NotificationDetails(
        android: AndroidNotificationDetails("regl_cycle_app", "counter",
            importance: Importance.min),
      );
  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
  }) async =>
      _notifications.show(id, title, body,await _notificationDetails());
}
