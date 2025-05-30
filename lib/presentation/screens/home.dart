import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/api/ai_notifications.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/widgets/components/custom_app_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                debugPrint('===============================********==================');

                NotificationService().scheduleNotification(
                  context: context,
                );
              },
              child: const Text("Schedule Noti"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.notification_add_outlined),
        onPressed: () async {
          var message = await AiNotifications().requestAIMessage(context);
          NotificationService().showNotification(
            title: message[0],
            body: message[1],
          );
        },
      ),
    );
  }
}
