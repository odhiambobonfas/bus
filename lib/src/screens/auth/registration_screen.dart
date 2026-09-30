import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../routes/app_route.dart'; // Import your routes

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Admin';
  bool _isLoading = false;
  String _error = '';

  final List<String> roles = ['Admin', 'Driver', 'Parent'];

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = "Email and password cannot be empty");
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // Save role and email in Firestore
      if (user != null) {
        final roleLower = _selectedRole.toLowerCase();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'email': email, 'role': roleLower});

        // Navigate based on role
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Registration successful')),
          );

          // Navigate to role-specific screen
          switch (roleLower) {
            case 'admin':
              Navigator.pushReplacementNamed(context, AppRoute.adminDashboard);
              break;
            case 'driver':
              Navigator.pushReplacementNamed(context, AppRoute.driverHome);
              break;
            case 'parent':
              Navigator.pushReplacementNamed(context, AppRoute.parentHome);
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('❌ Unknown role!')),
              );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? 'Registration failed';
      });
    } catch (e) {
      setState(() {
        _error = 'An unexpected error occurred';
      });
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: "Select Role"),
              items: roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
