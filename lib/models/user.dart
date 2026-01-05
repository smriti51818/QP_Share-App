/// Model class to represent a User/Student
/// Stores basic login information
class User {
  // Student's name
  final String name;

  // Roll number or Register number
  final String rollNumber;

  // Constructor
  User({
    required this.name,
    required this.rollNumber,
  });

  // Convert User to Map (for saving to SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNumber': rollNumber,
    };
  }

  // Create User from Map (for loading from SharedPreferences)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
    );
  }

  // Get display name (Name - Roll Number)
  String get displayName => '$name ($rollNumber)';
}

