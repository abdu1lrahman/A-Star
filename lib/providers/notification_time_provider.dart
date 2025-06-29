import 'package:flutter/material.dart';

class NotificationTimeProvider extends ChangeNotifier {
  final List<TimeOfDay> _notificationTimes = [
    const TimeOfDay(hour: 8, minute: 00),
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 20, minute: 00),
  ];

  List<TimeOfDay> get notificationTimes => _notificationTimes;

  void changeNotificationTime(TimeOfDay newTime, int index) async {
    switch (index) {
      case 0:
        {
          _notificationTimes[index] = newTime;
        }
        break;
      case 1:
        {
          _notificationTimes[index] = newTime;
        }
        break;
      case 2:
        {
          _notificationTimes[index] = newTime;
        }
        break;
      default:
    }
    notifyListeners();
  }
}
