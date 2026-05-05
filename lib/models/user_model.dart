class UserModel {
  final String id;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],
    );
  }
}