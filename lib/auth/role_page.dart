import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Role')),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Continue as...'),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/manager-login');
                        },
                        child: Image.asset(
                          'assets/images/cute_cat_placeholder.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('MANAGER')
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/tenant-login');
                        },
                        child: Image.asset(
                          'assets/images/cute_cat_placeholder.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('TENANT'),

                    ],
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}