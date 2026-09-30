import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignStudentBusScreen extends StatefulWidget {
  const AssignStudentBusScreen({super.key});

  @override
  State<AssignStudentBusScreen> createState() => _AssignStudentBusScreenState();
}

class _AssignStudentBusScreenState extends State<AssignStudentBusScreen> {
  String? _selectedStudentId;
  String? _selectedBusId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Student to Bus"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Select Student
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'student')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                final students = snapshot.data!.docs;

                return DropdownButtonFormField<String>(
                  value: _selectedStudentId,
                  decoration: const InputDecoration(
                    labelText: 'Select Student',
                    border: OutlineInputBorder(),
                  ),
                  items: students.map((student) {
                    return DropdownMenuItem<String>(
                      value: student.id,
                      child: Text(student['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedStudentId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            // Select Bus
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('buses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                final buses = snapshot.data!.docs;

                return DropdownButtonFormField<String>(
                  value: _selectedBusId,
                  decoration: const InputDecoration(
                    labelText: 'Select Bus',
                    border: OutlineInputBorder(),
                  ),
                  items: buses.map((bus) {
                    return DropdownMenuItem<String>(
                      value: bus.id,
                      child: Text(bus['busNumber']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedBusId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 30),

            // Assign Button
            ElevatedButton(
              onPressed: _selectedStudentId != null && _selectedBusId != null
                  ? () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_selectedStudentId)
                          .update({'busId': _selectedBusId});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Student assigned to bus successfully!")),
                      );

                      setState(() {
                        _selectedStudentId = null;
                        _selectedBusId = null;
                      });
                    }
                  : null,
              child: const Text("Assign Bus"),
            ),
          ],
        ),
      ),
    );
  }
}
