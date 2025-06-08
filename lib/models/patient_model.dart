class PatientModel {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String roomNumber;
  final String diagnosis;
  final DateTime admittedAt;
  final String pronouns;
  final String photoUrl;

  PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.roomNumber,
    required this.diagnosis,
    required this.admittedAt,
    required this.pronouns,
    required this.photoUrl,
  });

  String get fullName => '\$firstName \$lastName';
  String get displayNameWithPronouns => '\$fullName (\${pronouns.toLowerCase()})';

  factory PatientModel.fromMap(Map<String, dynamic> data) {
    return PatientModel(
      id: data['id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      age: data['age'],
      roomNumber: data['roomNumber'],
      diagnosis: data['diagnosis'],
      admittedAt: DateTime.parse(data['admittedAt']),
      pronouns: data['pronouns'] ?? 'prefer not to say',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'roomNumber': roomNumber,
      'diagnosis': diagnosis,
      'admittedAt': admittedAt.toIso8601String(),
      'pronouns': pronouns,
      'photoUrl': photoUrl,
    };
  }
}