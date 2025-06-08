class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? photoUrl; // Nullable for default placeholder
  final int level;         // Gamification: experience level
  final int xp;            // Gamification: current experience points

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.photoUrl,
    this.level = 1,
    this.xp = 0,
  });

  String get fullName => '$firstName $lastName';

  String get initials {
  final f = firstName.isNotEmpty ? firstName[0] : '';
  final l = lastName.isNotEmpty ? lastName[0] : '';
  return (f + l).toUpperCase();
}

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? photoUrl,
    int? level,
    int? xp,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      level: level ?? this.level,
      xp: xp ?? this.xp,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      level: data['level'] ?? 1,
      xp: data['xp'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
      'level': level,
      'xp': xp,
    };
  }
}
