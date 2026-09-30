import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignParentStudentScreen extends StatefulWidget {
  const AssignParentStudentScreen({super.key});

  @override
  State<AssignParentStudentScreen> createState() => _AssignParentStudentScreenState();
}

class _AssignParentStudentScreenState extends State<AssignParentStudentScreen> {
  String? _selectedStudentId;
  String? _selectedParentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Parent to Student"),
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

            // Select Parent
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'parent')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                final parents = snapshot.data!.docs;

                return DropdownButtonFormField<String>(
                  value: _selectedParentId,
                  decoration: const InputDecoration(
                    labelText: 'Select Parent',
                    border: OutlineInputBorder(),
                  ),
                  items: parents.map((parent) {
                    return DropdownMenuItem<String>(
                      value: parent.id,
                      child: Text(parent['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedParentId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 30),

            // Assign Button
            ElevatedButton(
              onPressed: _selectedStudentId != null && _selectedParentId != null
                  ? () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_selectedStudentId)
                          .update({'parentId': _selectedParentId});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Parent assigned to student successfully!")),
                      );

                      setState(() {
                        _selectedStudentId = null;
                        _selectedParentId = null;
                      });
                    }
                  : null,
              child: const Text("Assign Parent"),
            ),
          ],
        ),
      ),
    );
  }
}
