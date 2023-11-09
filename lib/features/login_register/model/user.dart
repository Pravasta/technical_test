import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isVerified,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        name: json['name'],
        email: json['email'],
        isVerified: json['isVerified'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'isVerified': isVerified,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        isVerified,
      ];
}
