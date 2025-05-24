import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:you_are_a_star/data/api/ai_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');

    const initSettingsIOS = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationPlugin.initialize(initSettings);

    _isInitialized = true;

  }

  NotificationDetails notificationDetails(String? title, String? body) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'motivational_channel',
        'Motivational Notifications',
        channelDescription: 'Daily motivational notifications',
        importance: Importance.max,
        priority: Priority.high,
        enableLights: true,
        sound: const RawResourceAndroidNotificationSound('my_sound'),
        styleInformation: BigTextStyleInformation(
          body!,
          contentTitle: title,
        ),
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(title, body),
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    required BuildContext context,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final times = [
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 8, 00), // 8:00 AM
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 14, 00), // 2:00 PM
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 0), // 8:00 PM
    ];

    for (int i = 0; i < times.length; i++) {
      var message = await AiNotifications().requestAIMessage(context);
      await notificationPlugin.zonedSchedule(
        i,
        message[0],
        message[1],
        times[i],
        notificationDetails(message[0], message[1]),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}
