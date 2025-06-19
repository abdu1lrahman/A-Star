import 'package:flutter/material.dart';

class NotificationTimeProvider extends ChangeNotifier {
  List<TimeOfDay> _notificationTimes = [
    TimeOfDay(hour: 8, minute: 00),
    TimeOfDay(hour: 14, minute: 00),
    TimeOfDay(hour: 20, minute: 00),
  ];
  List<TimeOfDay> get notificationTimes => _notificationTimes;

  void changeNotificationTime(TimeOfDay newTime, int index) {
    _notificationTimes[index] = newTime;
    notifyListeners();
  }
}
