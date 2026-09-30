import 'package:flutter/material.dart';
import '../screens/auth/auth_service.dart';
import '../utils/role_enum.dart';

class AppDrawer extends StatelessWidget {
  final String role;

  const AppDrawer({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Secure Bus App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          if (role == UserRole.parent.name)
            ListTile(
              leading: const Icon(Icons.child_care),
              title: const Text('My Child'),
              onTap: () {
                Navigator.pushNamed(context, '/childStatus');
              },
            ),
          if (role == UserRole.driver.name)
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Check-in Students'),
              onTap: () {
                Navigator.pushNamed(context, '/studentCheckin');
              },
            ),
          if (role == UserRole.admin.name)
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Admin Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/adminDashboard');
              },
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await AuthService().signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
