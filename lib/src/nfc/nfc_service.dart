import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NFCService {
  /// Starts an NFC polling session and returns the scanned tag ID
  static Future<String?> scanNfcTag() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      return tag.id;
    } catch (e) {
      // Log or rethrow error if needed
      return null;
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  /// Optionally you can send tag ID to backend here
  static Future<bool> sendCheckInDataToServer(String tagId) async {
    try {
      // Example placeholder for HTTP request or database call
      // await http.post(...);
      await Future.delayed(const Duration(seconds: 1)); // simulate delay
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cancels any ongoing NFC session (optional to expose)
  static Future<void> cancelSession() async {
    await FlutterNfcKit.finish();
  }
}
