import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTimeProvider extends ChangeNotifier {
  List<TimeOfDay> _notificationTimes = [
    TimeOfDay(hour: 8, minute: 00),
    TimeOfDay(hour: 14, minute: 00),
    TimeOfDay(hour: 20, minute: 00),
  ];

  List<TimeOfDay> get notificationTimes => _notificationTimes;

  void getNotificationTimes() async {
    final prefs = await SharedPreferences.getInstance();
    List<TimeOfDay> savedNotificationTimes = [];
    for (int i = 0; i < 3; i++) {
      int hour, minute;
      hour = prefs.getInt("Hour$i") ?? 8 + (i * 6);
      minute = prefs.getInt("Minute$i") ?? 0;
      savedNotificationTimes[i] = TimeOfDay(hour: hour, minute: minute);
    }
    _notificationTimes = savedNotificationTimes;
    notifyListeners();
  }

  void changeNotificationTime(TimeOfDay newTime, int index) async {
    final prefs = await SharedPreferences.getInstance();
    switch (index) {
      case 0:
        {
          _notificationTimes[index] = newTime;
          await prefs.setInt("Hour0", newTime.hour);
          await prefs.setInt("Minute0", newTime.minute);
        }
        break;
      case 1:
        {
          _notificationTimes[index] = newTime;
          await prefs.setInt("Hour1", newTime.hour);
          await prefs.setInt("Minute1", newTime.minute);
        }
        break;
      case 2:
        {
          _notificationTimes[index] = newTime;
          await prefs.setInt("Hour2", newTime.hour);
          await prefs.setInt("Minute2", newTime.minute);
        }
        break;
      default:
    }
    notifyListeners();
  }
}
