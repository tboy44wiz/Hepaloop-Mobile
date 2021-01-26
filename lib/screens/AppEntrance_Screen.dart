import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/utils/App_SnackBar.dart';

class AppEntranceScreen extends StatelessWidget {
  //  Call the instance of AppSnackBar
  AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    //  Custom SnackBar.
    SnackBar _snackBar(String toastMessage) {
      return SnackBar(
        content: Text(
          toastMessage,
          style: TextStyle(color: Colors.black45),
        ),
        backgroundColor: Colors.grey[300],
      );
    }

    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar:
            _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 0.0,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'images/app_logo.png',
                  height: 300,
                  width: 300,
                ),
              ),

              //  Get Started Button Wrapper.
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.pushReplacementNamed(context, loginScreen),
                    },
                    padding: EdgeInsets.all(0.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Ink(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff19769F), Color(0xff35D8A6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0.0,
                      ),
                      child: Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
