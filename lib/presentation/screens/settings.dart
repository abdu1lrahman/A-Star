import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  String _theme = 'LightMode';

  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final timeProvider = Provider.of<NotificationTimeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(S.of(context).general),
          _buildDropdownTile(
            S.of(context).language,
            langProvider.local.languageCode == 'en' ? 'English' : 'العربية',
            ["English", "العربية"],
            (val) {
              langProvider.changeLocale((val == "English") ? 'en' : 'ar');
            },
          ),
          _buildDropdownTile(
            S.of(context).theme,
            _theme,
            ['LightMode', 'DarkMode'],
            (val) {
              setState(() {
                _theme = val!;
                themeProvider.setTheme(val);
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(S.of(context).notification),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.tertiary,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            title: Text(
              S.of(context).enable_noti,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          if (_notificationsEnabled)
            ...List.generate(
              3,
              (index) {
                final time = timeProvider.notificationTimes[index];
                return ListTile(
                  title: Text(
                    '${S.of(context).noti} ${index + 1}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    time.format(context),
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: timeProvider.notificationTimes[index],
                    );
                    if (picked != null) {
                      timeProvider.changeNotificationTime(picked, index);
                    }
                  },
                );
              },
            ),
          const SizedBox(height: 20),
          _buildSectionHeader(S.of(context).account),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'intro', (Route<dynamic> route) => false);
            },
            child: const Text('Delete my Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdownTile<T>(
    String title,
    T currentValue,
    List<T> options,
    ValueChanged<T?> onChanged,
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: DropdownButton<T>(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        value: currentValue,
        onChanged: onChanged,
        items: options.map((val) {
          return DropdownMenuItem<T>(
            value: val,
            child: Text('$val'),
          );
        }).toList(),
      ),
    );
  }
}
