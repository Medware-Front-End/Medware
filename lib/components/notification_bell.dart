import 'package:flutter/material.dart';
import 'package:medware/screens/notifications/notifications.dart';
import 'package:medware/utils/colors.dart';

class NotificationBell extends StatelessWidget {
  final Color backgroundColor;
  const NotificationBell({Key? key, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Notifications())),
      icon: Icon(
        Icons.notifications,
        color: backgroundColor.computeLuminance() > 0.5
            ? primaryColor
            : quaternaryColor,
        size: size.width * 0.08,
      ),
    );
  }
}
