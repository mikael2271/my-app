import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    this.email,
    this.token,
    this.name,
    required this.lastTimeLogged,
  });

  final String? email;
  String? token;
  String? name;
  String? cellphone;
  DateTime lastTimeLogged;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'last_time_logged': lastTimeLogged.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      name: map['name'] ?? '',
      lastTimeLogged: map.containsKey('last_time_logged')
          ? DateTime.parse(map['last_time_logged'])
          : DateTime(2020),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
