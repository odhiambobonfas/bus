import 'package:flutter/material.dart';

class RouteInfoScreen extends StatelessWidget {
  final List<Map<String, String>> routeStops = [
    {"stop": "Stop 1", "time": "7:00 AM"},
    {"stop": "Stop 2", "time": "7:15 AM"},
    {"stop": "Stop 3", "time": "7:30 AM"},
    {"stop": "School", "time": "7:50 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Information'),
      ),
      body: ListView.builder(
        itemCount: routeStops.length,
        itemBuilder: (context, index) {
          final stop = routeStops[index];
          return ListTile(
            leading: Icon(Icons.location_on),
            title: Text(stop["stop"] ?? ""),
            subtitle: Text("Arrival: ${stop["time"]}"),
          );
        },
      ),
    );
  }
}
