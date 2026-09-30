import 'package:flutter/material.dart';
import '../../components/loading_spinner.dart';

// If NfcService is not defined in the above import, define a mock or real NfcService here for demonstration:
class NfcService {
  static Future<String?> readNfcTag() async {
    // TODO: Implement actual NFC reading logic or use a package like flutter_nfc_kit
    // For now, return a mock ID after a short delay
    await Future.delayed(Duration(seconds: 2));
    return "1234567890";
  }
}

// Ensure that NfcService is defined in '../../nfc/nfc_service.dart'.
// If not, update the import path below to the correct file where NfcService is implemented.
// Example: import 'package:your_project/services/nfc_service.dart';

class StudentCheckInScreen extends StatefulWidget {
  const StudentCheckInScreen({super.key});

  @override
  State<StudentCheckInScreen> createState() => _StudentCheckInScreenState();
}

class _StudentCheckInScreenState extends State<StudentCheckInScreen> {
  String? scannedId;
  String? statusMessage;
  bool isScanning = false;

  void _startNfcScan() async {
    setState(() {
      isScanning = true;
      statusMessage = null;
    });

    try {
      final tagId = await NfcService.readNfcTag();

      if (tagId != null) {
        setState(() {
          scannedId = tagId;
          statusMessage = "Student with ID $tagId checked in successfully!";
        });

        // TODO: Send check-in data to backend or database
      } else {
        setState(() {
          statusMessage = "No NFC tag found. Try again.";
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "Error reading NFC tag: $e";
      });
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student NFC Check-In"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tap student NFC wristband to check in',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            if (isScanning)
              const LoadingSpinner()
            else
              ElevatedButton.icon(
                onPressed: _startNfcScan,
                icon: const Icon(Icons.nfc),
                label: const Text("Scan NFC Tag"),
              ),
            const SizedBox(height: 30),
            if (scannedId != null)
              Text(
                "Scanned ID: $scannedId",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (statusMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  statusMessage!,
                  style: TextStyle(
                    fontSize: 16,
                    color: statusMessage!.contains("success") ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
