import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coming Soon')),
      body: Center(
        child: Text(
          'This page is under construction',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
