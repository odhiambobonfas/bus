import 'package:flutter/material.dart';
import '../shared/splash_screen.dart';
import 'login_screen.dart';
import '../shared/welcome_screen.dart';
import '../shared/role_selection_screen.dart';
import '../driver/driver_home.dart';
import '../driver/student_checkin_screen.dart';
import '../parent/parent_home.dart';
import '../parent/child_status_screen.dart';
import '../admin/admin_dashboard.dart';
import '../admin/student_logs_screen.dart';
import '../../utils/app_constants.dart';

class AppNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.routeSplash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppConstants.routeLogin:
        final args = settings.arguments as Map<String, dynamic>?;
        final role = args?['role'] ?? 'guest'; // fallback role
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));

      case AppConstants.routeWelcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case AppConstants.routeRoleSelect:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case AppConstants.routeDriverHome:
        return MaterialPageRoute(builder: (_) => const DriverHome());

      case '/checkin':
        return MaterialPageRoute(builder: (_) => const StudentCheckInScreen());

      case AppConstants.routeParentHome:
        return MaterialPageRoute(builder: (_) => const ParentHome());

      case '/child-status':
        return MaterialPageRoute(builder: (_) => const ChildStatusScreen());

      case AppConstants.routeAdminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());

      case '/logs':
        return MaterialPageRoute(builder: (_) => const StudentLogsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
