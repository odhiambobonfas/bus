import 'package:flutter/material.dart';
import '../../screens/auth/auth_service.dart';
import '../../../routes/app_route.dart';

class LoginScreen extends StatefulWidget {
  final String role;

  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _error = '';

  void _login() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await _authService.signIn(email, password);

    if (user != null) {
      debugPrint("✅ Logged in as: ${user.email}");

      final roleFromDb = await _authService.getUserRole(user.uid);
      debugPrint("📥 Firestore role: $roleFromDb | 🔘 Selected role: ${widget.role}");

      if (roleFromDb == null) {
        _showError("No role assigned to this account in Firestore.");
      } else if (roleFromDb.toLowerCase() == widget.role.toLowerCase()) {
        _navigateToRoleScreen(roleFromDb.toLowerCase());
      } else {
        _showError("Incorrect role for this account.");
      }
    } else {
      _showError("Invalid email or password.");
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToRoleScreen(String role) {
    switch (role) {
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
        _showError("Unknown role: $role");
    }
  }

  void _showError(String message) {
    if (mounted) {
      setState(() => _error = message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text("Login"),
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
