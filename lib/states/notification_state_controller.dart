
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../database/dao/notification_DAO.dart';
import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';


class NotificationStateController extends GetxController {

  //  State variables.
  List<dynamic> _allNotifications = [];
  bool _isPendingNotification = true;
  String _userId = "";
  String _token = "";

  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();


  //
  /*
  * GETTERS
  * */
  String get userId => _userId;
  String get token => _token;
  List<dynamic> get  allNotifications => _allNotifications;
  bool get isPendingNotification => _isPendingNotification;


  //
  /*
  * SETTERS
  * */
  void updateUserId(String value) {
    _userId = value;
    update();
  }
  void updateToken(String value) {
    _token = value;
    update();
  }
  void updateAllNotifications(List<dynamic> notifications, bool isPending) {
    _allNotifications = notifications;
    _isPendingNotification = isPending;
    update();
  }


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // getAllNotificationsFromSQFLiteDatabase();
      // getAllUsersNotifications();
    });
  }


  /*
  * Show Users Notification Request Dialog.
  * */
  void showNotificationRequestDialog() {
    //  Show user a Notification Authorization dialog box.
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        Get.dialog(
          AlertDialog(
              title: const Text('Allow Notifications'),
              content: const Text('Hepaloop would like to send you notifications. '),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Don\'t allow',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Get.back());
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                        color: Color(0xff19769F),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          barrierDismissible: false
        );
      }
    });
  }


  /*
  * Notification Actions Listener
  * (When a notification is clicked from the notification slide-down tray).
  * */
  void notificationActionListener() {
    AwesomeNotifications().actionStream.listen((ReceivedAction receivedAction) {
      Get.toNamed(notificationScreen);
    });
  }

  /*
  * Create Notification Contents.
  * */
  void createNotificationContents(int id, String channelKey, String title, String body, String largeIconURL, NotificationLayout notificationLayout) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        largeIcon: largeIconURL,
        roundedLargeIcon: true,
        notificationLayout: notificationLayout
      ),
    );
  }


  /*
  * Get All Notifications from the SQFLite Database.
  * */
  Future<void> getAllNotificationsFromSQFLiteDatabase() async {
    List<Map<String, dynamic>> notifications = await getAllNotificationsFromDatabase();
    bool isPending = notifications.any((eachNotification) => eachNotification["isDelivered"] == 0);
    updateAllNotifications(notifications, isPending);
  }


  /*
  * Get All Notifications from the Server
  * */
  Future<void> getAllUsersNotifications() async {
    var _usersData = await _flutterSecureStorage.read(key: 'loggedInUser');
    if (_usersData != null) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);
      updateUserId(_decodedUSerData["id"]);
      updateToken(_decodedUSerData["token"]);
    }
    var response = await APIService.getAllUsersNotifications(getAllUsersNotificationsRoute, _userId, _token);

    bool isSuccess = response!.data["success"];
    if (isSuccess) {
      List<dynamic> notifications = response.data["data"];

      bool isPending = notifications.any((eachNotification) => eachNotification["isDelivered"] == false);
      updateAllNotifications(notifications, isPending);
    }
  }



  /*
  * Get Notification Time.
  * */
  String getNotificationTime(DateTime dateTime) {
    String formattedDate;

    //  If current date id greater than the date of the notification, then
    if (DateTime.now().day > dateTime.day) {
      DateFormat dateFormatter = DateFormat("MMM dd");
      formattedDate = dateFormatter.format(dateTime);
    } else {
      DateFormat dateFormatter = DateFormat.jm();
      formattedDate = dateFormatter.format(dateTime);
    }
    return formattedDate;
  }


  /*
  * Update Notification in the SQFLite Database.
  * */
  Future<void> updateNotificationInSQFLiteDatabase(String id) async {
    Map<String, dynamic> notificationUpdateData = {
      "id": id,
      "isDelivered": 1
    };
    int response = await updateSingleNotificationInDatabase(notificationUpdateData);
    if (response == 1) {
      getAllNotificationsFromSQFLiteDatabase();
    }
  }

  /*
  * Update Notification in the Server.
  * */
  Future<void> updateNotificationInServer(String id) async {

    //  Send back a successful delivery message to the server.
    Map<String, dynamic> notificationAPIData = {
      "isDelivered": true
    };
    await APIService.updateSingleNotificationService(updateSingleNotificationRoute, id, notificationAPIData);
  }
}