import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:you_are_a_star/data/api/ai_notifications.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();
      if (status.isDenied) {
        Fluttertoast.showToast(
          msg: "Please enable notifications in settings for the best experience",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }

    if (await Permission.scheduleExactAlarm.isDenied){
      final status = await Permission.scheduleExactAlarm.request();
      if (status.isDenied) {
        Fluttertoast.showToast(
          msg: "Please enable exact alarm permission in settings for precise notifications",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
    final bool? granted = await notificationPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    if (granted != true) {
      Fluttertoast.showToast(
        msg: "Exact alarm permission needed for precise notifications",
        toastLength: Toast.LENGTH_LONG,
      );
    }

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

  Future<void> scheduleNotification(BuildContext context) async {
    final now = tz.TZDateTime.now(tz.local);

    final timeProvider = Provider.of<NotificationTimeProvider>(context, listen: false);

    List<TimeOfDay> newTimes = timeProvider.notificationTimes;

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

    // Get current date in YYYY-MM-DD format
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // Check if we have a saved quote and if it's from today
    final lastQuoteDate = Prefs.prefs.getString('last_messages_date');

    if (lastQuoteDate != today) {
      for (int attempt = 0; attempt < times.length; attempt++) {
        Map<String, String>? message;
        try {
          message = await AiNotifications().requestAIMessage();
          await Prefs.prefs.setInt('messages_count', UserProvider().messagesCount + 1);
        } catch (e) {
          await Future.delayed(const Duration(seconds: 2));
          message = await AiNotifications().requestAIMessage();
        }

        await notificationPlugin.zonedSchedule(
          attempt,
          message?['title'],
          message?['body'],
          times[attempt],
          notificationDetails(message?['title'], message?['body']),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }
      await Prefs.prefs.setString('last_quote_date', today);
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
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint("========= Special Notification Scheduled =========");
  }
}
