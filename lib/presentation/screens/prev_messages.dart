import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';
import 'package:share_plus/share_plus.dart';

class PrevMessages extends StatefulWidget {
  const PrevMessages({super.key});

  @override
  State<PrevMessages> createState() => _PrevMessagesState();
}

class _PrevMessagesState extends State<PrevMessages> {
  SqfliteDb db = SqfliteDb();
  List<Map> prevMessages = [];
  bool isLoading = true;

  getPreviousMessages() async {
    List<Map> response = await db.readData("SELECT * FROM messages");
    setState(() {
      prevMessages = response.reversed.toList();
      isLoading = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    getPreviousMessages();
  }

  @override
  void initState() {
    getPreviousMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).prev_messages)),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : prevMessages.isEmpty
                ? Center(child: Text(S.of(context).no_prev))
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: ListView.builder(
                      itemCount: prevMessages.length,
                      itemBuilder: (context, index) => Card(
                        color: themeProvider.currentAppTheme.mainColor,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await db.deleteData(
                                    'DELETE FROM messages WHERE id=${prevMessages[index]['id']}',
                                  );
                                  setState(() {
                                    getPreviousMessages();
                                  });
                                },
                                backgroundColor:
                                    themeProvider.currentAppTheme.fifthColor,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (context) async {
                                  final share = SharePlus.instance;
                                  await share.share(
                                    ShareParams(
                                      title: S.of(context).share_motivation,
                                      text:
                                          '${prevMessages[index]['title']}\n${prevMessages[index]['body']}',
                                    ),
                                  );
                                },
                                backgroundColor:
                                    themeProvider.currentAppTheme.forthColor,
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                              ),
                              SlidableAction(
                                onPressed: (context) async {
                                  int hour = 10, minute = 10;
                                  final now = DateTime.now();
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: now.hour,
                                      minute: now.minute,
                                    ),
                                  );

                                  if (picked != null) {
                                    setState(() {
                                      hour = picked.hour;
                                      minute = picked.minute;
                                    });
                                  }
                                  NotificationService()
                                      .scheduleSpecialNotification(
                                    hour,
                                    minute,
                                    prevMessages[index]['title'],
                                    prevMessages[index]['body'],
                                  ); // TODO: the toast message doesn't appear doto build context across asnyc gaps error
                                  Fluttertoast.showToast(
                                    // ignore: use_build_context_synchronously
                                    msg: S.of(context).archived_message_confirm,
                                  );
                                },
                                borderRadius:
                                    languageProvider.local.languageCode == 'en'
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          )
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                backgroundColor:
                                    themeProvider.currentAppTheme.thirdColor,
                                foregroundColor: Colors.white,
                                icon: Icons.archive,
                              ),
                            ],
                          ),
                          child: ListTile(
                            isThreeLine: true,
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    prevMessages[index]['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    prevMessages[index]['date'],
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.03),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Text(prevMessages[index]['body']),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
