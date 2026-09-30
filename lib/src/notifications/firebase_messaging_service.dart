import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize FCM, request permissions, and set up listeners
  static Future<void> initializeFCM(BuildContext context) async {
    // Request permissions (for iOS)
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    // Get and log the device token
    final token = await _messaging.getToken();
    debugPrint('Device FCM Token: $token');

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('FCM Message received in foreground: ${message.notification?.title}');
      _showForegroundNotification(context, message);
    });

    // Handle when app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('FCM onMessageOpenedApp: ${message.notification?.title}');
      // You can navigate to a specific screen if needed
    });

    // Optionally handle when app launches from terminated state
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('FCM initialMessage: ${initialMessage.notification?.title}');
      // Handle the message or navigate
    }
  }

  /// Show a simple dialog for foreground messages
  static void _showForegroundNotification(BuildContext context, RemoteMessage message) {
    if (message.notification != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification!.title ?? 'Notification'),
          content: Text(message.notification!.body ?? 'You have a new message'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
