import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../../models/notification_model.dart';

//
//  DatabaseHelper class instance variable.
DatabaseHelper _databaseHelper = DatabaseHelper();

//
//  Table name.
const String _notificationTableName = 'notification';

//
//  Table columns.
const String _notificationId = 'id';
const String _type = 'type';
const String _title = 'title';
const String _refId = 'refId';
const String _userId = 'userId';
const String _senderId = 'senderId';
const String _receiverId = 'receiverId';
const String _senderFullName = 'senderFullName';
const String _senderImage = 'senderImage';
const String _content = 'content';
const String _isDelivered = 'isDelivered';
const String _createdAt = 'createdAt';
const String _updatedAt = 'updatedAt';

//
//  Create Notification's Table.
const String createNotificationTable = """CREATE TABLE $_notificationTableName(
  $_notificationId TEXT NOT NULL PRIMARY KEY,
  $_type TEXT NOT NULL,
  $_title TEXT NOT NULL,
  $_refId TEXT NOT NULL,
  $_userId TEXT NOT NULL,
  $_senderId TEXT NOT NULL,
  $_receiverId TEXT NOT NULL,
  $_senderFullName TEXT NOT NULL,
  $_senderImage TEXT NOT NULL,
  $_content TEXT NOT NULL,
  $_isDelivered INTEGER NOT NULL,
  $_createdAt TEXT NOT NULL,
  $_updatedAt TEXT NOT NULL
)""";

//
//
// Insert a single Notification into the SQFLite Database.
Future<int> saveNotificationToDatabase(AppNotification notification) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.insert(
      _notificationTableName,
      notification.toMap()
    );
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
// Get All Notifications.
Future<List<Map<String, dynamic>>> getAllNotificationsFromDatabase() async {
  try {
    var dbClient = await _databaseHelper.database;
    var notifications =  await dbClient.rawQuery("SELECT * FROM $_notificationTableName");
    return notifications.toList();
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
//  Get single Notification.
Future<AppNotification?> getSingleNotification(String notificationId) async {
  try {
    var dbClient = await _databaseHelper.database;
    var response = await dbClient.query(
      _notificationTableName,
      columns: null,
      where: "$_notificationId = ?",
      whereArgs: [notificationId],
    );

    if (response.isNotEmpty) {
      return AppNotification.fromMap(response.first);
    }
    return null;
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
//  Update single Notification.
Future<int> updateSingleNotificationInDatabase(Map<String, dynamic> acceptNotificationData) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.update(
      _notificationTableName,
      acceptNotificationData,
      where: "$_notificationId = ?",
      whereArgs: [acceptNotificationData["id"]],
    );
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
//  Get single saved Notifications.
Future<int> deleteSingleNotification(String notificationId) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.delete(
      _notificationTableName,
      where: "$_notificationId = ?",
      whereArgs: [notificationId],
    );
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
//  Get Notification count.
Future<int?> getAllNotificationCount() async {
  try {
    var dbClient = await _databaseHelper.database;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $_notificationTableName"),
    );
  } catch (e) {
    print("SQFLITE ERROR::: $e");
    throw Exception(e);
  }
}

//
//  Close Database.
Future<void> closeDatabase() async {
  var dbClient = await _databaseHelper.database;
  dbClient.close();
}