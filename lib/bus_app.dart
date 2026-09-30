import 'package:flutter/material.dart';
import 'routes/app_route.dart';
import 'src/utils/app_styles.dart';
import 'src/screens/auth/auth_screen.dart'; // Import this

class BusApp extends StatelessWidget {
  const BusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure School Bus Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: AppStyles.scaffoldColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87,
              displayColor: Colors.black87,
            ),
      ),
      home: AuthScreen(role: 'Parent'), // 👈 Load this screen first
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
