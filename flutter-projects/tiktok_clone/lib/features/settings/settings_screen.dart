import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? value) {
    if (value == null) return;
    setState(() {
      _notifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: context.watch<VideoConfig>().isMuted,
            onChanged: (value) => context.read<VideoConfig>().toggleIsMuted(),
            title: const Text('Mute video'),
            subtitle: const Text('Video will be muted by default.'),
          ),
          SwitchListTile.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text('Enable notifications'),
            subtitle: const Text('Enable notifications'),
          ),
          CheckboxListTile.adaptive(
            activeColor: Colors.black,
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text('Enable notifications'),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2030),
              );
              debugPrint('$date');
              if (!context.mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              debugPrint('$time');
              if (!context.mounted) return;
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              debugPrint('$booking');
            },
            title: const Text('What is your birthday?'),
          ),
          ListTile(
            title: const Text('Log out (iOS)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog<void>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Plz dont go'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('No'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log out (Android)'),
            textColor: Colors.red,
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text('Are you sure?'),
                  content: const Text('Plz dont go'),
                  actions: [
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: const FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log out (iOS / Bottom)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text('Are you sure?'),
                  message: const Text('Plaese dooont go'),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Not log out'),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Yes, plz'),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
