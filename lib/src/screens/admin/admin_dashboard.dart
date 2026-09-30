import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/app_drawer.dart';
import '../shared/splash_screen.dart';
import 'student_logs_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<Map<String, int>> _fetchDashboardStats() async {
    final students = await _getUserCountByRole('student');
    final parents = await _getUserCountByRole('parent');
    final drivers = await _getUserCountByRole('driver');
    final buses = await _getBusCount();

    return {
      'students': students,
      'parents': parents,
      'drivers': drivers,
      'buses': buses,
    };
  }

  Future<int> _getUserCountByRole(String role) async {
    final query = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();
    return query.docs.length;
  }

  Future<int> _getBusCount() async {
    final query = await FirebaseFirestore.instance.collection('buses').get();
    return query.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const AppDrawer(role: 'admin'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('View Student Logs'),
                subtitle: const Text('Check pickup/drop-off history'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentLogsScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('System Summary'),
                subtitle: const Text('Statistics and current status'),
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: CircularProgressIndicator()),
                  );

                  final data = await _fetchDashboardStats();
                  Navigator.pop(context); // remove loading

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('System Summary'),
                      content: Text(
                        '• Total Students: ${data['students']}\n'
                        '• Total Parents: ${data['parents']}\n'
                        '• Total Drivers: ${data['drivers']}\n'
                        '• Active Buses: ${data['buses']}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
