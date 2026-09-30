class AppConstants {
  // App-wide constants
  static const String appName = 'Secure School Bus App';
  static const String apiBaseUrl = 'https://your-backend-url.com/api'; // Replace with your real API

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userRoleKey = 'user_role';
  static const String userIdKey = 'user_id';

  // NFC constants
  static const String nfcTagPrefix = 'bus_nfc_';

  // Notification channels (for Android)
  static const String notificationChannelId = 'secure_bus_channel';
  static const String notificationChannelName = 'Bus Alerts';
  static const String notificationChannelDescription = 'Notifications for student pick-up and drop-off';

  // Routes
  static const String routeSplash = '/splash';
  static const String routeLogin = '/login';
  static const String routeWelcome = '/welcome';
  static const String routeRoleSelect = '/role-select';
  static const String routeParentHome = '/parent-home';
  static const String routeDriverHome = '/driver-home';
  static const String routeAdminDashboard = '/admin-dashboard';
}
