import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import '../components/loading_spinner.dart';

class NFCScanScreen extends StatefulWidget {
  const NFCScanScreen({super.key});

  @override
  State<NFCScanScreen> createState() => _NFCScanScreenState();
}

class _NFCScanScreenState extends State<NFCScanScreen> {
  String _status = "Tap a student NFC wristband to scan.";
  String? _nfcId;
  bool _scanning = false;

  Future<void> _scanNFC() async {
    setState(() {
      _status = "Scanning...";
      _scanning = true;
      _nfcId = null;
    });

    try {
      NFCTag tag = await FlutterNfcKit.poll();
      setState(() {
        _nfcId = tag.id;
        _status = "Student ID Scanned: ${tag.id}";
      });

      // You can now pass the ID to your backend or log the check-in
      // e.g., sendCheckInDataToServer(tag.id);
    } catch (e) {
      setState(() {
        _status = "Error scanning NFC: $e";
      });
    } finally {
      await FlutterNfcKit.finish();
      setState(() {
        _scanning = false;
      });
    }
  }

  @override
  void dispose() {
    FlutterNfcKit.finish(); // ensure session is closed on exit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Student NFC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_scanning)
              const LoadingSpinner(message: "Hold the wristband near your device...")
            else
              Column(
                children: [
                  Text(
                    _status,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.nfc),
                    label: const Text("Start Scan"),
                    onPressed: _scanNFC,
                  ),
                  if (_nfcId != null) ...[
                    const SizedBox(height: 16),
                    Text("NFC Tag ID: $_nfcId",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]
                ],
              ),
          ],
        ),
      ),
    );
  }
}
