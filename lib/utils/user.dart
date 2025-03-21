import 'dart:typed_data';

class User {
  final String id;
  final String displayName;
  final String email;
  final Uint8List profilePicture;
  final String description;
  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.description,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      description: json['description'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'description': description,
      'profilePicture': profilePicture,
    };
  }
}
