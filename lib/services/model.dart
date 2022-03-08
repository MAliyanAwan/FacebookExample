import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    required this.password,
    required this.email,
  });

  final String email;
  final String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        // json["dob"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [email];
}
