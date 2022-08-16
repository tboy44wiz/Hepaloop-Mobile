import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../database/dao/notification_DAO.dart';
import '../models/notification_model.dart';
import '../routes/api_routes/api_route_names.dart';
import '../states/notification_state_controller.dart';
import '../widgets/app_snackBar_widget.dart';
import '../services/api_service.dart';

class SocketIOServiceController extends GetxController {

  IO.Socket? _socket;
  Map<dynamic, dynamic>? _token;

  // Class Instances.
  final NotificationStateController _notificationStateController = Get.put(NotificationStateController());
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final AppSnackBar _appSnackBar = AppSnackBar();


  //
  /*
  * GETTERS
  * */
  IO.Socket? get socket => _socket;


  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

      //  Manual Connection.
      createSocketConnection() async {
        try {

          var _usersData = await _flutterSecureStorage.read(key: "loggedInUser");

          if (_usersData != null) {

            //  Extract the token.
            Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);
            _token = {
              "token": _decodedUSerData["token"]
            };

            _socket = IO.io(
              // "https://hepaloop-api.herokuapp.com",
                "http://192.168.43.244:5000",
                IO.OptionBuilder()
                    .setTransports(['websocket']) // for Flutter or Dart VM
                    .disableAutoConnect() // disable auto-connection
                    .setExtraHeaders({'foo': 'bar'}) // optional
                    .setAuth(_token!)
                    .build()
            );
            update();

            // Connect to Websockets manually.
            _socket!.connect();
          }

          //   When User connects.
          _socket!.onConnect((_) => print("You're connected..."));
          _socket!.on("connectionMessage", (connectionData) {
            print(connectionData["message"]);

            //  Call the SnackBar
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                _appSnackBar.snackBar(connectionData["message"], "Success")
            );
          });


          _socket!.on("notification", (notificationData) async {
            try {
              if (notificationData["success"]) {
                //  Remove "success" and "code" from the notificationData
                notificationData.remove("success");
                notificationData.remove("code");

                //  Save to Notification Model
                AppNotification notification = AppNotification.fromMap(notificationData);

                //  Save to SQFLite Database.
                await saveNotificationToDatabase(notification);


                //  Create Notification.
                _notificationStateController.createNotificationContents(
                    DateTime.now().millisecondsSinceEpoch.remainder(100000),
                    'consultation_notification_key',
                    notification.title!,
                    notification.content!,
                    notification.senderImage!,
                    NotificationLayout.BigPicture
                );

                //  Then send back a successful delivery message to the server.
                Map<String, dynamic> notificationAPIData = {
                  "isDelivered": true
                };
                await APIService.updateSingleNotificationService(updateSingleNotificationRoute, notificationData["id"], notificationAPIData);

              } else {
                //  Call the SnackBar
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                    _appSnackBar.snackBar(notificationData["message"], "Error")
                );
              }
            } catch (error) {
              return error;
            }
          });


          //   When User disconnects.
          _socket!.on("leave", (disconnectionData) => {
            print(disconnectionData["message"]),
          });
          _socket!.onDisconnect((_) => print("You're disconnected..."));

        } catch (e) {
          print(e.toString());
        }
      }
    });
  }

  //  Manual Connection.
  createSocketConnection() async {
    try {

      var _usersData = await _flutterSecureStorage.read(key: "loggedInUser");

      if (_usersData != null) {

        //  Extract the token.
        Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);
        _token = {
          "token": _decodedUSerData["token"]
        };

        _socket = IO.io(
          // "https://hepaloop-api.herokuapp.com",
          //   "http://192.168.43.244:5000",
            "http://192.168.1.14:5000",
            IO.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .disableAutoConnect() // disable auto-connection
                .setExtraHeaders({'foo': 'bar'}) // optional
                .setAuth(_token!)
                .build()
        );
        update();

        // Connect to Websockets manually.
        _socket!.connect();
      }

      //   When User connects.
      _socket!.onConnect((_) => print("You're connected..."));
      _socket!.on("connectionMessage", (connectionData) {
        print(connectionData["message"]);

        //  Call the SnackBar
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            _appSnackBar.snackBar(connectionData["message"], "Success")
        );
      });


      _socket!.on("notification", (notificationData) async {
        try {
          if (notificationData["success"]) {
            //  Remove "success" and "code" from the notificationData
            notificationData.remove("success");
            notificationData.remove("code");

            //  Save to Notification Model
            AppNotification notification = AppNotification.fromMap(notificationData);

            //  Save to SQFLite Database.
            await saveNotificationToDatabase(notification);


            //  Create Notification.
            _notificationStateController.createNotificationContents(
                DateTime.now().millisecondsSinceEpoch.remainder(100000),
                'consultation_notification_key',
                notification.title!,
                notification.content!,
                notification.senderImage!,
                NotificationLayout.BigPicture
            );

            //  Then send back a successful delivery message to the server.
            Map<String, dynamic> notificationAPIData = {
              "isDelivered": true
            };
            await APIService.updateSingleNotificationService(updateSingleNotificationRoute, notificationData["id"], notificationAPIData);

          } else {
            //  Call the SnackBar
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                _appSnackBar.snackBar(notificationData["message"], "Error")
            );
          }
        } catch (error) {
          return error;
        }
      });


      //   When User disconnects.
      _socket!.on("leave", (disconnectionData) => {
        print(disconnectionData["message"]),
      });
      _socket!.onDisconnect((_) => print("You're disconnected..."));

    } catch (e) {
      print(e.toString());
    }
  }
}