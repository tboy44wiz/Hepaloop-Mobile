import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/routes/app_routes/App_Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences _sharedPreferences =
      await SharedPreferences.getInstance();
  String _loggedInUser = (_sharedPreferences.getString('loggedInUser') ?? '');

  var _decodedLoggedInUser;
  try {
    _decodedLoggedInUser = jsonDecode(_loggedInUser);
  } catch (e) {
    print('EXCEPTION::: $e');
  }

  runApp(MyApp(
    loggedInUserDetails: _decodedLoggedInUser,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> loggedInUserDetails;

  const MyApp({Key key, this.loggedInUserDetails}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _initialRoute = (loggedInUserDetails == null)
        ? (appHomeScreen)
        : ((loggedInUserDetails['loggedInAs'] == 'Doctor')
            ? doctorDashBoardScreen
            : (loggedInUserDetails['loggedInAs'] == 'Patient')
                ? patientDashBoardScreen
                : (loggedInUserDetails['loggedInAs'] == 'Pharmacy')
                    ? pharmacyDashBoardScreen
                    : appHomeScreen);

    return MaterialApp(
      title: 'Hepaloop',

      //  App Theme.
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        accentColor: Colors.lightBlueAccent,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        //   Defines the Default Font Family.
        fontFamily: "Nunito",
      ),

      //  Page Routing.
      initialRoute: _initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

/*

(loggedInUserDetails['loggedInAs'] == 'Doctor')
          ? doctorDashBoardScreen
          : (loggedInUserDetails['loggedInAs'] == 'Patient')
              ? patientDashBoardScreen
              : (loggedInUserDetails['loggedInAs'] == 'Pharmacy')
                  ? pharmacyDashBoardScreen
                  : appHomeScreen,

* */
