// To parse this JSON data, do
//
//     final consultation = consultationFromMap(jsonString);

import 'dart:convert';

Consultation consultationFromMap(String str) => Consultation.fromMap(json.decode(str));

String consultationToMap(Consultation data) => json.encode(data.toMap());

class Consultation {

  String? id;
  String? userId;
  String? senderId;
  String? receiverId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Consultation({
    this.id,
    this.userId,
    this.senderId,
    this.receiverId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Consultation.fromMap(Map<String, dynamic> json) => Consultation(
    id: json["id"],
    userId: json["userId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "senderId": senderId,
    "receiverId": receiverId,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
