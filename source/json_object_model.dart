import "dart:convert";

import "package:equatable/equatable.dart";

/// {@template jsonObjectModel}
/// Extending this class will ensure that your class can be converted to a JSON
/// object.
/// {@endtemplate}
abstract class JsonObjectModel extends Equatable {
  const JsonObjectModel();

  /// Returns a [Map] representation of the object.
  Map<String, Object?> toJson();

  /// Returns a representation of [toJson] encoded as a [String] with
  /// [jsonEncode].
  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}

/// {@macro jsonObjectModel}
///
/// This class provide a default implementation of [toJson], based on the
/// [jsonKeys] property.
abstract class AutoJsonModel extends JsonObjectModel {
  const AutoJsonModel();

  /// Declare the keys used for the JSON. You must ensure that the length is the
  /// same as the [props].
  ///
  /// The keys will be associated to the [props] value at the same index.
  Set<String> get jsonKeys;

  @override
  Map<String, Object?> toJson() {
    assert(jsonKeys.length == props.length);
    final data = <String, Object?>{};
    for (int i = 0; i < jsonKeys.length; i++) {
      final key = jsonKeys.elementAt(i);
      final value = props.elementAt(i);
      data[key] = value;
    }
    return data;
  }
}

/// Example

const companyEntry = 'company';
const usernameEntry = 'username';
const passwordEntry = 'password';
const roleEntry = 'role';
const phoneEntry = 'phone';
const cellEntry = 'cell';

class MyUser extends JsonObjectModel {
  final String company;
  final String username;
  final String password;
  final String role;
  final String phone;
  final String cell;

  const MyUser({
    required this.company,
    required this.username,
    required this.password,
    required this.role,
    required this.phone,
    required this.cell,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      company: json[companyEntry] as String,
      username: json[usernameEntry] as String,
      password: json[passwordEntry] as String,
      role: json[roleEntry] as String,
      phone: json[phoneEntry] as String,
      cell: json[cellEntry] as String,
    );
  }

  @override
  List<Object?> get props => [
        company,
        username,
        password,
        role,
        phone,
        cell,
      ];

  @override
  Map<String, Object?> toJson() {
    return <String, Object?>{
      companyEntry: company,
      usernameEntry: username,
      passwordEntry: password,
      roleEntry: role,
      phoneEntry: phone,
      cellEntry: cell,
    };
  }
}

class MyUser2 extends AutoJsonModel {
  final String company;
  final String username;
  final String password;
  final String role;
  final String phone;
  final String cell;

  const MyUser2({
    required this.company,
    required this.username,
    required this.password,
    required this.role,
    required this.phone,
    required this.cell,
  });

  @override
  Set<String> get jsonKeys => <String>{
        companyEntry,
        usernameEntry,
        passwordEntry,
        roleEntry,
        phoneEntry,
        cellEntry,
      };

  @override
  List<Object?> get props => [
        company,
        username,
        password,
        role,
        phone,
        cell,
      ];
}
