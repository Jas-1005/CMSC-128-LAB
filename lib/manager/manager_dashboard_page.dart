import 'package:flutter/material.dart';
import 'manager_helper.dart';

class ManagerDashboardPage extends StatefulWidget {
  const ManagerDashboardPage({super.key});

  @override
  State<ManagerDashboardPage> createState() => _ManagerDashboardPageState();
}

class _ManagerDashboardPageState extends State<ManagerDashboardPage> {
  static final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.payment, 'label': 'Manage Tenants'},
    {'icon': Icons.calendar_month, 'label': 'Input Dues'},
    {'icon': Icons.payments, 'label': 'View Payment'},
    {'icon': Icons.house, 'label': 'About'},
  ];

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
                Text('Hello, Manager!'),
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