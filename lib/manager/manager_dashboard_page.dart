import 'package:flutter/material.dart';
import 'manager_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerDashboardPage extends StatefulWidget {
  const ManagerDashboardPage({super.key});

  @override
  State<ManagerDashboardPage> createState() => _ManagerDashboardPageState();
}

class _ManagerDashboardPageState extends State<ManagerDashboardPage> {
  static final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.payment, 'label': 'Manage Tenants', 'route': '/manager-manage-tenants'},
    {'icon': Icons.payments, 'label': 'View Payment', 'route': '/manager-view-payment'},
    {'icon': Icons.house, 'label': 'About', 'route': '/manager-about'},
  ];

    String managerName = "";
    bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _listenAndLoadManagerFullName(); // Start listening and loading when widget initializes
  }

  void _listenAndLoadManagerFullName() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      // This listener will give you the most up-to-date user object
      // whenever the auth state changes.
      if (user != null) {
        // User is signed in, proceed to load data
        setState(() {
          _isLoading = true; // Show loading indicator
        });
        await _loadManagerData(user); // Pass the user object to the loading function
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      } else {
        // User is signed out or not logged in. Clear data and show signed out state.
        setState(() {
          managerName = "Not logged in";
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _loadManagerData(User user) async { // Now accepts User object
    print("Manager is not null, UID: ${user.uid}");

    try {
      final managerUserQuery = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isEqualTo: user.uid)
          .where('role', isEqualTo: 'manager')// Use the user object passed to the function
          .get();

      if(managerUserQuery.docs.isEmpty){
        print("No manager found with UID: ${user.uid}");
        setState(() {
          managerName = "Manager profile not found";
        });
        return;
      }


      final managerData = managerUserQuery.docs.first.data();
      setState(() {
        managerName = managerData['fullName'] as String? ?? "N/A";
      });
      // print("Manager Collection Exists: YES");

    } catch (e) {
      print("Error loading manager data: $e");
      setState(() {
        managerName = "Error loading data";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello, Manager $managerName!'),
                Icon(
                  Icons.notifications,
                  size: 30,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Announcements:',
                            style: TextStyle(
                                fontSize: 24
                            ),
                          )
                      ),

                      Row(
                        children: [
                          Icon(Icons.add),
                          Icon(Icons.edit),
                          Icon(Icons.delete),
                        ],
                      )
                    ],
                  ),

                  Text('Power outage notice: Scheduled maintenance on Oct. 17, 1-3PM. Expect temporary interruption!'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/announcement');
                          },
                          child: Text('>')
                      )
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Overview:',
                        style: TextStyle(
                            fontSize: 24
                        ),
                      )
                  ),
                  Table(
                    children: [
                      TableRow(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Tenants'),
                                Text('20')
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () => Navigator.pushNamed(context, '/manager-add-tenant'),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add),
                                      Text('Add Tenant')
                                    ],
                                  ),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pending Payments'),
                                Text('Php 18,450')
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pending Reports'),
                                Text('5')
                              ],
                            ),
                          ]
                      )
                    ],
                  ),
                  Table(
                    children: List.generate(
                      (menuItems.length / 4).ceil(), // number of rows
                          (rowIndex) {
                        final int startIndex = rowIndex * 4;
                        final int endIndex = (startIndex + 4).clamp(0, menuItems.length);
                        final rowItems = menuItems.sublist(startIndex, endIndex);

                        // Fill empty cells if less than 4 items
                        while (rowItems.length < 4) {
                          rowItems.add({'icon': null, 'label': ''});
                        }

                        return TableRow(
                          children: rowItems.map((item) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(context, item['route']),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (item['icon'] != null) Icon(item['icon'], size: 50),
                                    if ((item['label'] ?? '').isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          item['label'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            );
                          }).toList(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ManagerHelper.buildNavItems(context)
            ),
          ],
        ),
      ),
    );
  }
}