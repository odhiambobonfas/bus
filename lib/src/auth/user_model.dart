class AppUser {
  final String uid;
  final String email;
  final String? name;
  final String role; // e.g., 'student', 'parent', 'driver', 'admin'

  AppUser({
    required this.uid,
    required this.email,
    this.name,
    required this.role,
  });

  // Convert AppUser to Map (useful for saving to Firestore or local DB)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
    };
  }

  // Create AppUser from Map (e.g., from Firestore)
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
    );
  }

  // For debugging
  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, role: $role)';
  }
}
