import 'package:flutter/material.dart';

// Shared Screens
import '../src/screens/shared/splash_screen.dart';

// Auth
import '../src/screens/auth/login_screen.dart';
import '../src/screens/auth/registration_screen.dart';
import '../src/screens/auth/auth_screen.dart'; // ✅ used below

// Driver Screens
import '../src/screens/driver/driver_home.dart';

// Parent Screens
import '../src/screens/parent/parent_home.dart';
import '../src/screens/parent/child_status_screen.dart';

// Admin Screens
import '../src/screens/admin/admin_dashboard.dart';
import '../src/screens/admin/student_logs_screen.dart';
import '../src/screens/admin/manage_users.dart';
import '../src/screens/admin/assign_parent_to_student.dart';
import '../src/screens/admin/assign_student_to_bus.dart';

class AppRoute {
  // Shared
  static const String splash = '/splash';
  static const String login = '/login';
  static const String auth = '/auth'; // ✅ added

  // Admin
  static const String adminDashboard = '/admin/dashboard';
  static const String adminStudentLogs = '/admin/student_logs';
  static const String adminRegister = '/admin/register';
  static const String adminManageUsers = '/admin/manage_users';
  static const String adminAssignParentStudent = '/admin/assign_parent_student';
  static const String adminAssignStudentBus = '/admin/assign_student_bus';

  // Driver
  static const String driverHome = '/driver/home';
  static const String driverCheckin = '/driver/checkin';

  // Parent
  static const String parentHome = '/parent/home';
  static const String parentChildStatus = '/parent/child_status';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Shared
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case auth: // ✅ use AuthScreen
        final args = settings.arguments as Map<String, dynamic>?;
        final role = args?['role'] as String? ?? 'unknown';
        return MaterialPageRoute(builder: (_) => AuthScreen(role: role));
      case login:
        final args = settings.arguments as Map<String, dynamic>?;
        final role = args?['role'] as String?;
        return MaterialPageRoute(
          builder: (_) => LoginScreen(role: role ?? 'unknown'),
        );

      // Admin
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case adminStudentLogs:
        return MaterialPageRoute(builder: (_) => const StudentLogsScreen());
      case adminRegister:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case adminManageUsers:
        return MaterialPageRoute(builder: (_) => const ManageUsersScreen());
      case adminAssignParentStudent:
        return MaterialPageRoute(builder: (_) => const AssignParentStudentScreen());
      case adminAssignStudentBus:
        return MaterialPageRoute(builder: (_) => const AssignStudentBusScreen());

      // Driver
      case driverHome:
        return MaterialPageRoute(builder: (_) => const DriverHome());
      case driverCheckin:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('🚌 Driver Check-in screen not implemented')),
          ),
        );

      // Parent
      case parentHome:
        return MaterialPageRoute(builder: (_) => const ParentHome());
      case parentChildStatus:
        return MaterialPageRoute(builder: (_) => const ChildStatusScreen());

      // Default fallback
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('🚫 No route defined for: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
