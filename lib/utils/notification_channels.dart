import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


var notificationChannels = [
  NotificationChannel(
      channelKey: 'consultation_notification_key',
      channelName: 'Consultation Notification',
      channelDescription: 'Notification channel for consultation request.',
      channelShowBadge: true,
      defaultColor: const Color(0xff19769F),
      defaultRingtoneType: DefaultRingtoneType.Notification,
      enableLights: true,
      enableVibration: true,
      vibrationPattern: lowVibrationPattern,
      importance: NotificationImportance.High,
      ledColor: Colors.green,
      playSound: true
  ),
];