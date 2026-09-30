import 'package:flutter/material.dart';
import '../../utils/app_constants.dart'; // ✅ Ensure this import exists for AppConstants

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _navigateToLogin(BuildContext context, String role) {
    Navigator.pushNamed(
      context,
      AppConstants.routeLogin, // ✅ Use named route
      arguments: {'role': role.toLowerCase()}, // ✅ Pass the selected role
    );
  }

  @override
  Widget build(BuildContext context) {
    final roles = ['driver', 'parent', 'admin'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        backgroundColor: Colors.teal[700],
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(30.0),
          itemCount: roles.length,
          itemBuilder: (context, index) {
            final role = roles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 60),
                ),
                icon: _getRoleIcon(role),
                label: Text(
                  role,
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () => _navigateToLogin(context, role),
              ),
            );
          },
        ),
      ),
    );
  }

  Icon _getRoleIcon(String role) {
    switch (role) {
      case 'driver':
        return const Icon(Icons.directions_bus);
      case 'parent':
        return const Icon(Icons.family_restroom);
      case 'admin':
        return const Icon(Icons.admin_panel_settings);
      default:
        return const Icon(Icons.person);
    }
  }
}
