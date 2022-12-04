import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    this.email,
    this.token,
    this.name,
    required this.lastTimeLoged,
  });

  final String? email;
  String? token;
  String? name;
  String? cellphone;
  DateTime lastTimeLoged;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'last_time_loged': lastTimeLoged.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      name: map['name'] ?? '',
      lastTimeLoged: map.containsKey('last_time_loged')
          ? DateTime.parse(map['last_time_loged'])
          : DateTime(2020),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
