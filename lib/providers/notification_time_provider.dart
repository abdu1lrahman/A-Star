import 'package:flutter/material.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class NotificationTimeProvider extends ChangeNotifier {
  List<TimeOfDay> _notificationTimes = [
    const TimeOfDay(hour: 8, minute: 00),
    const TimeOfDay(hour: 12, minute: 00),
    const TimeOfDay(hour: 20, minute: 00),
  ];

  List<TimeOfDay> get notificationTimes => _notificationTimes;

  void getNotificationTimes() async {
    List<TimeOfDay> savedNotificationTimes = [];
    List<int> defaultHours = [8, 12, 20];
    for (int i = 0; i < _notificationTimes.length; i++) {
      int hour, minute;

      hour = Prefs.prefs.getInt("Hour$i") ?? defaultHours[i];
      minute = Prefs.prefs.getInt("Minute$i") ?? 0;
      savedNotificationTimes.add(TimeOfDay(hour: hour, minute: minute));
    }
    _notificationTimes = savedNotificationTimes;
    notifyListeners();
  }

   void changeNotificationTime(TimeOfDay newTime, int index) async {
    if (index >= 0 && index < _notificationTimes.length) {
      _notificationTimes[index] = TimeOfDay(hour: newTime.hour, minute: newTime.minute);
      
      // Save to preferences
      await Prefs.prefs.setInt("Hour$index", newTime.hour);
      await Prefs.prefs.setInt("Minute$index", newTime.minute);
      
      notifyListeners();
    }
  }
}
