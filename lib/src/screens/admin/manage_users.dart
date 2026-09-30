import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  String _searchQuery = '';
  String _selectedRole = 'All';

  final List<String> _roles = ['All', 'driver', 'parent', 'student'];

  void _deleteUser(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

  void _editUser(BuildContext context, DocumentSnapshot userDoc) {
    final nameController = TextEditingController(text: userDoc['name']);
    String selectedRole = userDoc['role'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: ['driver', 'parent', 'student']
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedRole = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userDoc.id)
                  .update({
                'name': nameController.text.trim(),
                'role': selectedRole,
              });

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search + Role Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search by name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value.toLowerCase());
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: _roles
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedRole = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // User List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: usersQuery.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                  final users = snapshot.data!.docs.where((doc) {
                    final name = doc['name'].toString().toLowerCase();
                    final role = doc['role'].toString();

                    final matchesSearch = name.contains(_searchQuery);
                    final matchesRole = _selectedRole == 'All' || _selectedRole == role;

                    return matchesSearch && matchesRole;
                  }).toList();

                  if (users.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(user['name']),
                          subtitle: Text("Role: ${user['role']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editUser(context, user),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(user.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
