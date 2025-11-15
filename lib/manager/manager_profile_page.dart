import 'package:flutter/material.dart';
import 'manager_helper.dart';

class ManagerProfilePage extends StatefulWidget {
  const ManagerProfilePage({super.key});

  @override
  State<ManagerProfilePage> createState() => _ManagerProfilePageState();
}

class _ManagerProfilePageState extends State<ManagerProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Profile')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: Text('Logout')
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ManagerHelper.buildNavItems(context)
            ),
          ]
      ),
    );
  }
}