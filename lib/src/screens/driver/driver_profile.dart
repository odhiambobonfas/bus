import 'package:flutter/material.dart';

class DriverProfileScreen extends StatelessWidget {
  // Sample static profile data (replace with dynamic/fetched data)
  final Map<String, String> profileData = {
    'Name': 'John Doe',
    'Email': 'john.doe@schoolbus.com',
    'Phone': '+1234567890',
    'Bus ID': 'BUS-101',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: profileData.entries.map((entry) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
