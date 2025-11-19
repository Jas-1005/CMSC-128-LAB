import 'package:flutter/material.dart';

class TenantHelper {
  static final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home', 'route': '/tenant-dashboard'},
    {'icon': Icons.question_answer_outlined, 'label': 'Chat', 'route': '/tenant-chat'},
    {'icon': Icons.handshake, 'label': 'Transaction', 'route': '/tenant-transaction'},
    {'icon': Icons.account_circle, 'label': 'Profile', 'route': '/tenant-profile'},
  ];

  static List<Widget> buildNavItems(BuildContext context) {
    return navItems.map((item) {
      return Material(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pushNamed(context, item['route']),
          child: SizedBox(
            width: 80,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['icon'], size: 30),
                Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}