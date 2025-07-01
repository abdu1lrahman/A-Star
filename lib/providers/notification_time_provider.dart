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
      hour = prefs.getInt("firstHour") ?? 8;
      minute = prefs.getInt("firstMinute") ?? 0;
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
          await prefs.setInt("firstHour", newTime.hour);
          await prefs.setInt("firstMinute", newTime.minute);
        }
        break;
      case 1:
        {
          _notificationTimes[index] = newTime;
          await prefs.setInt("secondHour", newTime.hour);
          await prefs.setInt("secondMinute", newTime.minute);
        }
        break;
      case 2:
        {
          _notificationTimes[index] = newTime;
          await prefs.setInt("thirdHour", newTime.hour);
          await prefs.setInt("thirdMinute", newTime.minute);
        }
        break;
      default:
    }
    notifyListeners();
  }
}
