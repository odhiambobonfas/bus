import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream to listen to authentication state changes
  Stream<User?> get userChanges => _auth.authStateChanges();

  /// Sign in using email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("🔴 Sign-in failed: $e");
      return null;
    }
  }

  /// Get user role from Firestore using UID
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        print("⚠️ No user document found for UID: $uid");
        return null;
      }

      final data = doc.data();
      final role = data?['role'];

      if (role is String) {
        return role;
      } else {
        print("⚠️ Role field is missing or not a string.");
        return null;
      }
    } catch (e) {
      print("🔴 Error fetching user role: $e");
      return null;
    }
  }

  /// Register user with email and password
  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("🔴 Registration error: $e");
      return null;
    }
  }

  /// Sign out the currently logged-in user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("🔴 Sign-out error: $e");
    }
  }

  /// Get the current user
  User? getCurrentUser() => _auth.currentUser;

  /// Send email verification to the current user (if not already verified)
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print("🔴 Email verification error: $e");
    }
  }

  /// Check if the current user's email is verified
  Future<bool> isEmailVerified() async {
    try {
      final user = _auth.currentUser;
      await user?.reload();
      return user?.emailVerified ?? false;
    } catch (e) {
      print("🔴 Error checking email verification: $e");
      return false;
    }
  }
}
