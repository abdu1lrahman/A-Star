import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:you_are_a_star/data/api/ai_notifications.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    final bool? granted = await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (_isInitialized) return;

    if (granted != true) {
      Fluttertoast.showToast(
          msg: "Please give the app notifications permissions");
    }

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

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

  Future<void> scheduleNotification() async {
    final now = tz.TZDateTime.now(tz.local);

    List<TimeOfDay> newTimes = NotificationTimeProvider().notificationTimes;

    final times = [
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        newTimes[0].hour,
        newTimes[0].minute,
      ),
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        newTimes[1].hour,
        newTimes[1].minute,
      ),
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        newTimes[2].hour,
        newTimes[2].minute,
      ),
    ];

    for (int i = 0; i < times.length; i++) {
      var message = await AiNotifications().requestAIMessage();
      await notificationPlugin.zonedSchedule(
        i,
        message?['title'],
        message?['body'],
        times[i],
        notificationDetails(message?['title'], message?['body']),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> scheduleSpecialNotification(
    int hour,
    int minute,
    String title,
    String body,
  ) async {
    final now = tz.TZDateTime.now(tz.local);

    await notificationPlugin.zonedSchedule(
      3,
      title,
      body,
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute),
      notificationDetails(title, body),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint("========= Special Notification Scheduled =========");
  }
}
