class UserProfileModel {
  final int id;
  final String email;
  final String? fullName;
  final int? age;

  UserProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.age,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      fullName: json['fullName'],
      age: json['age'] is int ? json['age'] : int.tryParse(json['age']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'age': age,
    };
  }
}
