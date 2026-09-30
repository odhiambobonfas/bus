import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final String? message;
  final Color spinnerColor;
  final double size;

  const LoadingSpinner({
    super.key,
    this.message,
    this.spinnerColor = Colors.blue,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              color: spinnerColor,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
