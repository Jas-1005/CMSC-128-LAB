import 'package:flutter/material.dart';
import 'tenant_helper.dart';

class TenantDashboardPage extends StatefulWidget {
  const TenantDashboardPage({super.key});

  @override
  State<TenantDashboardPage> createState() => _TenantDashboardPageState();
}

class _TenantDashboardPageState extends State<TenantDashboardPage> {
  static final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.payment, 'label': 'Pay'},
    {'icon': Icons.calendar_month, 'label': 'Dues'},
    {'icon': Icons.cloud_upload_outlined, 'label': 'Upload Proof'},
    {'icon': Icons.error_outline, 'label': 'Report Issue'},
    {'icon': Icons.house, 'label': 'About'},
    {'icon': Icons.notifications, 'label': 'Announcement'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenant Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Hello, Tenant!')
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
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Announcements:',
                        style: TextStyle(
                            fontSize: 24
                        ),
                      )
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
                        'Upcoming Dues:',
                        style: TextStyle(
                            fontSize: 24
                        ),
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Php 2,950',
                            style: TextStyle(
                                fontSize: 28
                            ),
                          ),
                          Text(
                            'Due on 10/31/25',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/transaction');
                              },
                              child: Text('Pay Now')
                          ),
                          Text(
                            'Tap Pay Now to settle dues securely.',
                            style: TextStyle(
                                fontSize: 8
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('Rent:'),
                            Text('Php 2,500')
                          ],
                        ),
                        Column(
                          children: [
                            Text('Water:'),
                            Text('Php 100')
                          ],
                        ),
                        Column(
                          children: [
                            Text('Electricity:'),
                            Text('Php 350')
                          ],
                        ),
                        Column(
                          children: [
                            Text('Total:'),
                            Text('Php 2,950')
                          ],
                        )
                      ],
                    ),
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
                children: TenantHelper.buildNavItems(context)
            ),
          ],
        ),
      ),
    );
  }
}