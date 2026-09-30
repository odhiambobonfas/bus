import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../components/loading_spinner.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  List<Map<String, dynamic>> notifications = [];

  Future<void> fetchNotifications() async {
    try {
      setState(() => isLoading = true);

      // Optionally, filter by parentId if you track it
      QuerySnapshot snapshot = await _firestore
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .get();

      setState(() {
        notifications = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'title': data['title'] ?? 'No Title',
            'message': data['message'] ?? 'No message',
            'timestamp': data['timestamp']?.toDate(),
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        notifications = [];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.teal[700],
      ),
      body: isLoading
          ? const LoadingSpinner()
          : notifications.isEmpty
              ? const Center(child: Text("No notifications yet."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Card(
                      child: ListTile(
                        title: Text(notification['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification['message']),
                            const SizedBox(height: 5),
                            Text(
                              notification['timestamp'] != null
                                  ? notification['timestamp']
                                      .toString()
                                      .substring(0, 16)
                                  : "Unknown time",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
