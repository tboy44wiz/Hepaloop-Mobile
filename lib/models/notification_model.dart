// To parse this JSON data, do
//
//     final appNotification = appNotificationFromMap(jsonString);

import 'dart:convert';

AppNotification appNotificationFromMap(String str) => AppNotification.fromMap(json.decode(str));

String appNotificationToMap(AppNotification data) => json.encode(data.toMap());

class AppNotification {

  String? id;
  String? type;
  String? title;
  String? refId;
  String? userId;
  String? senderId;
  String? receiverId;
  String? senderFullName;
  String? senderImage;
  String? content;
  bool? isDelivered;
  DateTime? updatedAt;
  DateTime? createdAt;

  AppNotification({
    this.id,
    this.type,
    this.title,
    this.refId,
    this.userId,
    this.senderId,
    this.receiverId,
    this.senderFullName,
    this.senderImage,
    this.content,
    this.isDelivered,
    this.updatedAt,
    this.createdAt,
  });

  factory AppNotification.fromMap(Map<String, dynamic> json) => AppNotification(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    refId: json["refId"],
    userId: json["userId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    senderFullName: json["senderFullName"],
    senderImage: json["senderImage"],
    content: json["content"],
    isDelivered: json["isDelivered"] == 1,
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "title": title,
    "refId": refId,
    "userId": userId,
    "senderId": senderId,
    "receiverId": receiverId,
    "senderFullName": senderFullName,
    "senderImage": senderImage,
    "content": content,
    "isDelivered": isDelivered! ? 1 : 0,
    "updatedAt": updatedAt!.toIso8601String(),
    "createdAt": createdAt!.toIso8601String(),
  };
}
