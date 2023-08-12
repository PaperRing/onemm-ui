import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final String _name;
  final String _email;

  User(this._name, this._email);

  factory User.empty() => User("", "");

  String get name => _name;

  String get email => _email;

  Map<String, dynamic> toMap() {
    return {
      '_name': _name,
      '_email': _email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['_name'] as String,
      map['_email'] as String,
    );
  }
}
