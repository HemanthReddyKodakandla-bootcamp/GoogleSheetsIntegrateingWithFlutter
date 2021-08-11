import 'dart:convert';

import 'package:flutter_app_script_example/modals/user_fields.dart';

List<UserDataMModal> userDataMModalFromMap(String str) => List<UserDataMModal>.from(json.decode(str).map((x) => UserDataMModal.fromMap(x)));

String userDataMModalToMap(List<UserDataMModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserDataMModal {
  UserDataMModal({
    this.name,
    this.mobileNumber,
    this.email,
    this.age,
  });

  String? name;
  String? mobileNumber;
  String? email;
  String? age;

  factory UserDataMModal.fromMap(Map<String, dynamic> json) => UserDataMModal(
    name: json[UserFields.name]!,
    mobileNumber: json[UserFields.mobileNumber]!,
    email: json[UserFields.email]!,
    age: json[UserFields.age]!,
  );

  Map<String, dynamic> toMap() => {
    UserFields.name: name,
    UserFields.mobileNumber: mobileNumber,
    UserFields.email: email,
    UserFields.age: age,
  };
}