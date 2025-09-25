import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/widgets/custom_dropdowntile.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationTimeProvider>(context, listen: false).getNotificationTimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final timeProvider = Provider.of<NotificationTimeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(S.of(context).general),
          CustomDropdowntile(
            title: S.of(context).language,
            currentValue: langProvider.local.languageCode == 'en' ? 'English' : 'العربية',
            options: const ["English", "العربية"],
            onChanged: (val) {
              langProvider.toggleLanguage();
            },
          ),
          _buildThemeDropdownTile(
            S.of(context).theme,
            themeProvider.themeMode,
            [ThemeMode.light, ThemeMode.dark, ThemeMode.system],
            (val) {
              if (val != null) {
                setState(() {
                  themeProvider.setTheme(val);
                });
              }
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
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    debugPrint(
                        "=====================${picked?.hour} : ${picked?.minute}=====================");
                    if (picked != null) {
                      timeProvider.changeNotificationTime(picked, index);
                    }
                  },
                );
              },
            ),
          const SizedBox(height: 20),
          _buildSectionHeader(S.of(context).account),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  return const Color(0xff4B3842);
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  return Colors.grey[200];
                },
              ),
            ),
            onPressed: () async {
              try {
                await AuthService().signOut();
                
                Navigator.pushNamedAndRemoveUntil(
                    context, 'intro', (Route<dynamic> route) => false);
                    Prefs.prefs.clear();
              } on Exception catch (e) {
                debugPrint("++++++++++error while signing out ${e.toString()}+++++++++++++++++++");
              }
            },
            child: Text(S.of(context).signout),
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

  // Helper method to get icon for theme mode
  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.wb_sunny;
      case ThemeMode.dark:
        return Icons.nightlight_round;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }

  // Special dropdown tile for theme with icons
  Widget _buildThemeDropdownTile(
    String title,
    ThemeMode currentValue,
    List<ThemeMode> options,
    ValueChanged<ThemeMode?> onChanged,
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: DropdownButton<ThemeMode>(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        value: currentValue,
        onChanged: onChanged,
        items: options.map((themeMode) {
          return DropdownMenuItem<ThemeMode>(
            value: themeMode,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getThemeIcon(themeMode),
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  themeMode.name,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
