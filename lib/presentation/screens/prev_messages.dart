import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:you_are_a_star/generated/l10n.dart';

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

  @override
  void initState() {
    getPreviousMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).prev_messages,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : prevMessages.isEmpty
              ? const Center(child: Text('No Previous messages available.'))
              : ListView.builder(
                  itemCount: prevMessages.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(prevMessages[index]['title']),
                      subtitle: Text(prevMessages[index]['body']),
                      trailing: Text(prevMessages[index]['date']),
                    ),
                  ),
                ),
    );
  }
}
