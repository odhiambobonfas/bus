import 'package:flutter/material.dart';
import '../../components/app_drawer.dart';
import 'student_checkin_screen.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        backgroundColor: Colors.teal[700],
      ),
      drawer: const AppDrawer(role: 'driver'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome, Driver!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.nfc),
                title: const Text('NFC Check-In'),
                subtitle: const Text('Scan students on entry and exit'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentCheckInScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Route Info'),
                subtitle: const Text('View assigned pickup/drop route'),
                onTap: () {
                  // Future enhancement: Navigate to route map
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Route map coming soon!')),
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
                  Navigator.pop(context); // Simple logout action for now
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
