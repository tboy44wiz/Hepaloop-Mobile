import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hepaloop/states/notification_state_controller.dart';
import 'package:hepaloop/utils/notification_channels.dart';

import 'routes/app_routes/app_route_names.dart';
import 'routes/app_routes/app_routes.dart';

void main() async {
  //  Call this whenever you're using "async" in the "main" method.
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationStateController _notificationStateController = Get.put(NotificationStateController());

  //  Initialize the Awesome-Notification package. Always do this before the runApp() method.
  AwesomeNotifications().initialize(
    'resource://drawable/launcher_icon',
    notificationChannels,
      debug: true
  );
  _notificationStateController.notificationActionListener();

  FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  String _loggedInUser = await _flutterSecureStorage.read(key: 'loggedInUser') ?? "";

  //  Decode _loggedInUser
  Map<String, dynamic>? _decodedLoggedInUser;
  if (_loggedInUser.isNotEmpty) {
    _decodedLoggedInUser = jsonDecode(_loggedInUser);
  }

  runApp(MyApp(
    loggedInUserData: _decodedLoggedInUser,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? loggedInUserData;

  const MyApp({Key? key, this.loggedInUserData}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var _initialRoute = (loggedInUserData == null) ? (
    boardingOneScreen
    ) : (loggedInUserData!["role"] == "Doctor") ? (
        doctorsMainScreen
    ) : (loggedInUserData!["role"] == "Individual") ? (
        individualsMainScreen
    ) : (loggedInUserData!["role"] == "Hospital") ? (
        hospitalDashBoardScreen
    ) : (
        pharmacyDashBoardScreen
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hepaloop',

      //  App Theme.
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        //   Defines the Default Font Family.
      ),

      initialRoute: _initialRoute,
      getPages: getPages,
    );
  }
}
