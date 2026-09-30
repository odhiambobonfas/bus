import 'package:flutter/material.dart';
import 'child_status_screen.dart';

class ParentHome extends StatelessWidget {
  const ParentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Parent!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "What would you like to do?",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.person_pin_circle, color: Colors.teal),
              title: const Text("View Child Status"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChildStatusScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.teal),
              title: const Text("Notifications"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Placeholder: Add notification screen later
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Notifications feature coming soon!")),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                // Placeholder: Add logout logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
