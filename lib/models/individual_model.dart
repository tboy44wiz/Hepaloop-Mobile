// To parse this JSON data, do
//
//     final individual = individualFromMap(jsonString);

import 'dart:convert';

Individual individualFromMap(String str) => Individual.fromMap(json.decode(str));

String individualToMap(Individual data) => json.encode(data.toMap());

class Individual {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? picture;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? gender;
  DateTime? dob;
  int? age;
  String? height;
  String? weight;
  String? token;

  Individual({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.picture,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.dob,
    this.age,
    this.height,
    this.weight,
    this.token,
  });

  factory Individual.fromMap(Map<String, dynamic> json) => Individual(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    picture: json["picture"],
    role: json["role"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    age: json["age"],
    height: json["height"],
    weight: json["weight"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "picture": picture,
    "role": role,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "gender": gender,
    "dob": dob!.toIso8601String(),
    "age": age,
    "height": height,
    "weight": weight,
    "token": token,
  };
}
