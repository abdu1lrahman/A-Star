import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/language_provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void _showLanguageBottomSheet(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  (languageProvider.local.languageCode == 'en') ? Icons.flag : Icons.flag_outlined,
                ),
                title: const Text('English'),
                onTap: () {
                  languageProvider.setLocale(Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  (languageProvider.local.languageCode == 'ar') ? Icons.flag : Icons.flag_outlined,
                ),
                title: const Text('العربية '),
                onTap: () {
                  languageProvider.setLocale(Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'intro');
            },
            icon: Icon(Icons.outdoor_grill),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).language,
        onPressed: () {
          _showLanguageBottomSheet(context);
        },
      ),
    );
  }
}
