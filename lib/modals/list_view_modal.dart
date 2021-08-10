import 'dart:convert';

List<ListViewModal> listViewModalFromMap(String str) => List<ListViewModal>.from(json.decode(str).map((x) => ListViewModal.fromMap(x)));

String listViewModalToMap(List<ListViewModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ListViewModal {
  ListViewModal({
    this.name,
    this.email,
    this.mobileNo,
    this.age,
  });

  String? name;
  String? email;
  String? mobileNo;
  String? age;

  factory ListViewModal.fromMap(Map<String, dynamic> json) => ListViewModal(
    name: json["name"]??"",
    email: json["email"]??"",
    mobileNo: json["mobile_no"].toString(),
    age: json["age"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "age": age,
  };
}
