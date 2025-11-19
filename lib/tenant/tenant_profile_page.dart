import 'package:flutter/material.dart';
import 'tenant_helper.dart';

class TenantProfilePage extends StatefulWidget {
  const TenantProfilePage({super.key});

  @override
  State<TenantProfilePage> createState() => _TenantProfilePageState();
}

class _TenantProfilePageState extends State<TenantProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenant Profile')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: Text('Logout')
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: TenantHelper.buildNavItems(context)
            ),
          ]
      ),
    );
  }
}