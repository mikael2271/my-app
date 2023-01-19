import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  User({
    this.email,
    this.token,
    this.name,
    required this.lastTimeLogged,
  });

  factory User.fromJson(String source) =>
      User.fromMap(Map.castFrom(json.decode(source) as Map));

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'].toString(),
      name: (map['name'] ?? '').toString(),
      lastTimeLogged: map.containsKey('last_time_logged')
          ? DateTime.parse(map['last_time_logged'].toString())
          : DateTime(2020),
    );
  }

  final String? email;
  String? token;
  String? name;
  String? cellphone;
  DateTime lastTimeLogged;

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'last_time_logged': lastTimeLogged.toString(),
    };
  }

  String toJson() => json.encode(toMap());
}
