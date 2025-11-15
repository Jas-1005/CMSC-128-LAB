import 'package:flutter/material.dart';

import 'package:rentahanan/auth/auth.dart';
import 'package:rentahanan/manager/manager.dart';
import 'package:rentahanan/tenant/tenant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentahanan',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/role': (context) => const RolePage(),
        '/manager-login': (context) => const ManagerLoginPage(),
        '/tenant-login': (context) => const TenantLoginPage(),
        '/manager-dashboard': (context) => const ManagerDashboardPage(),
        '/manager-profile': (context) => const ManagerProfilePage(),
        '/tenant-dashboard': (context) => const TenantDashboardPage(),
        '/tenant-profile': (context) => const TenantProfilePage(),
      },
    );
  }
}






