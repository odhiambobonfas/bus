import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/loading_spinner.dart';

class ChildStatusScreen extends StatefulWidget {
  const ChildStatusScreen({super.key});

  @override
  State<ChildStatusScreen> createState() => _ChildStatusScreenState();
}

class _ChildStatusScreenState extends State<ChildStatusScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String childName = "Brian Otieno";
  String childId = "STU123456";
  String status = "Loading...";
  bool isLoading = true;

  Future<void> fetchChildStatus() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Example Firestore path: students/STU123456
      DocumentSnapshot doc = await _firestore
          .collection('students')
          .doc(childId)
          .get();

      if (doc.exists && doc['status'] != null) {
        setState(() {
          status = doc['status'];
          isLoading = false;
        });
      } else {
        setState(() {
          status = "No status found";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        status = "Error fetching status";
        isLoading = false;
      });
    }
  }

  Color getStatusColor() {
    switch (status) {
      case "Checked In - On the Bus":
        return Colors.green;
      case "Dropped Off":
        return Colors.red;
      case "Not Yet Checked In":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChildStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Child Status"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const LoadingSpinner()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Child Name: $childName",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Student ID: $childId",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Current Status:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: getStatusColor().withOpacity(0.1),
                    elevation: 3,
                    child: ListTile(
                      leading:
                          Icon(Icons.directions_bus, color: getStatusColor()),
                      title: Text(
                        status,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: fetchChildStatus,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh Status"),
                  )
                ],
              ),
      ),
    );
  }
}
