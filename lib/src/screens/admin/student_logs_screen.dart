import 'package:flutter/material.dart';

class StudentLogsScreen extends StatelessWidget {
  const StudentLogsScreen({super.key});

  // Mock data – Replace with real data from database later
  final List<Map<String, String>> logs = const [
    {
      'name': 'Jane W.',
      'status': 'Picked Up',
      'time': '7:45 AM',
      'location': 'Stage A',
    },
    {
      'name': 'Elijah M.',
      'status': 'Dropped Off',
      'time': '4:12 PM',
      'location': 'Stage B',
    },
    {
      'name': 'Angela N.',
      'status': 'Picked Up',
      'time': '7:50 AM',
      'location': 'Stage C',
    },
    {
      'name': 'David K.',
      'status': 'Dropped Off',
      'time': '4:00 PM',
      'location': 'Stage D',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Check-in Logs'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                log['status'] == 'Picked Up' ? Icons.login : Icons.logout,
                color: log['status'] == 'Picked Up' ? Colors.green : Colors.red,
              ),
              title: Text(log['name'] ?? 'Student'),
              subtitle: Text('${log['status']} at ${log['time']} - ${log['location']}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
