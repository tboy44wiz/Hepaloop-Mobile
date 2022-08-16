import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '../widgets/app_snackBar_widget.dart';
import '../routes/app_routes/app_route_names.dart';

class BoardingTwoScreen extends StatelessWidget {
  BoardingTwoScreen({Key? key}) : super(key: key);

  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.symmetric(
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
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: (){
                      Get.offNamed(loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Ink(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: const LinearGradient(
                            colors: [Color(0xff19769F), Color(0xff35D8A6)]
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0.0,
                      ),
                      child: const Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
