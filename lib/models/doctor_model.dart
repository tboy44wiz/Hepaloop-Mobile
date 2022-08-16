// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

Doctor userFromMap(String str) => Doctor.fromMap(jsonDecode(str));

String userToMap(Doctor data) => jsonEncode(data.toMap());

class Doctor {
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
  String? gender;
  String? specialty;
  String? hospital;
  DateTime? syop;
  String? bioInfo;
  String? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  Doctor({
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
    this.gender,
    this.specialty,
    this.hospital,
    this.syop,
    this.bioInfo,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
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
    gender: json["gender"],
    specialty: json["specialty"],
    hospital: json["hospital"],
    syop: DateTime.parse(json["syop"]),
    bioInfo: json["bioInfo"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "gender": gender,
    "specialty": specialty,
    "hospital": hospital,
    "syop": syop!.toIso8601String(),
    "bioInfo": bioInfo,
    "rating": rating,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "token": token,
  };
}
