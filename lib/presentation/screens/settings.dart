import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/language_provider.dart';
import 'package:you_are_a_star/presentation/providers/notification_time_provider.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  String _theme = 'theme1';

  bool _notificationsEnabled = true;

  Image _getThemeImage(String key) {
    return Image.asset('assets/images/$key.png', width: 120, height: 120);
  }

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
            ['theme1', 'theme2'],
            (val) {
              setState(() {
                _theme = val!;
                themeProvider.setTheme(val);
              });
            },
            itemBuilder: (val) => _getThemeImage(val),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(S.of(context).notification),
          SwitchListTile(
            activeColor: themeProvider.currentAppTheme.sixthColor,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            title: Text(S.of(context).enable_noti),
          ),
          if (_notificationsEnabled)
            ...List.generate(
              3,
              (index) {
                final time = timeProvider.notificationTimes[index];
                return ListTile(
                  title: Text('${S.of(context).noti} ${index + 1}'),
                  trailing: Text(time.format(context)),
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
      child: Text(title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDropdownTile<T>(
    String title,
    T currentValue,
    List<T> options,
    ValueChanged<T?> onChanged, {
    Widget Function(T val)? itemBuilder,
  }) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<T>(
        value: currentValue,
        onChanged: onChanged,
        items: options.map((val) {
          return DropdownMenuItem<T>(
            value: val,
            child: itemBuilder != null ? itemBuilder(val) : Text('$val'),
          );
        }).toList(),
      ),
    );
  }
}
