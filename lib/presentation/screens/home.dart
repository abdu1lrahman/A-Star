import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/api/ai_notifications.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class Home extends StatelessWidget {
  SqfliteDb db = SqfliteDb();
  int _counter = 0;
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).home)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                NotificationService().scheduleNotification();
              },
              child: const Text("Schedule Noti"),
            ),
            ElevatedButton(
              onPressed: () {
                db.insertData(
                  '''INSERT INTO messages ('title','body','date') VALUES ("Hello World$_counter","anything","18-6-2025")''',
                );
                _counter++;
              },
              child: const Text("add message"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.notification_add_outlined),
        onPressed: () async {
          var message = await AiNotifications().requestAIMessage();
          NotificationService().showNotification(
            title: message[0],
            body: message[1],
          );
        },
      ),
    );
  }
}
