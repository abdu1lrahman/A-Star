import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/language_provider.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  String _theme = 'Light';
  bool _notificationsEnabled = true;
  final List<TimeOfDay> _notificationTimes = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 14, minute: 0),
    const TimeOfDay(hour: 20, minute: 0),
  ];
  int _dailyGoal = 5;
  String _startWeekOn = 'Sunday';

  Future<void> _pickTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTimes[index],
    );
    if (picked != null) {
      setState(() => _notificationTimes[index] = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(S.of(context).general),
          _buildDropdownTile(
              S.of(context).language,
              langProvider.local.languageCode == 'en' ? 'English' : 'العربية',
              ["English", "العربية"], (val) {
            langProvider.changeLocale((val == "English") ? 'en' : 'ar');
          }),
          _buildDropdownTile('Theme', _theme, ['Light', 'Dark', 'System'], (val) {
            setState(() {
              _theme = val!;
              themeProvider.toggleTheme();
            });
          }),
          const SizedBox(height: 20),
          _buildSectionHeader(S.of(context).notification),
          SwitchListTile(
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            title: const Text('Enable Notifications'),
          ),
          if (_notificationsEnabled)
            ...List.generate(3, (index) {
              final time = _notificationTimes[index];
              return ListTile(
                title: Text('Notification ${index + 1}'),
                trailing: Text(time.format(context)),
                onTap: () => _pickTime(index),
              );
            }),
          const SizedBox(height: 20),
          _buildSectionHeader('User Preferences'),
          ListTile(
            title: const Text('Daily Goal'),
            trailing: DropdownButton<int>(
              value: _dailyGoal,
              onChanged: (val) => setState(() => _dailyGoal = val!),
              items: [1, 3, 5, 10]
                  .map((num) => DropdownMenuItem(value: num, child: Text('$num tasks')))
                  .toList(),
            ),
          ),
          _buildDropdownTile('Start Week On', _startWeekOn, ['Sunday', 'Monday'], (val) {
            setState(() => _startWeekOn = val!);
          }),
          const SizedBox(height: 20),
          _buildSectionHeader('Account'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Delete my Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDropdownTile<T>(
    String title,
    T currentValue,
    List<T> options,
    ValueChanged<T?> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<T>(
        value: currentValue,
        onChanged: onChanged,
        items: options.map((val) => DropdownMenuItem(value: val, child: Text('$val'))).toList(),
      ),
    );
  }
}
