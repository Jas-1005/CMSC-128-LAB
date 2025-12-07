import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Landing Page')),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'RENTAHANAN',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('GET STARTED')
              )
            ],
          ),
        )
    );
  }
}