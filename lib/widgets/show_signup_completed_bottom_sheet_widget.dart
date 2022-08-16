import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes/app_route_names.dart';

class ShowSignUpCompletedBottomSheetWidget {
  static void showSignUpCompletedBottomSheet(String userType) {
    Get.bottomSheet(
      Container(
        height: 400.0,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15.0,
        ),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  Animated Image.
                  Image.asset(
                    'images/animated_check_mark.gif',
                    height: 100.0,
                    width: 100.0,
                  ),

                  const Padding(padding: EdgeInsets.all(7.0)),

                  // Congratulations.
                  const Text(
                    'Congratulations!!!',
                    style: TextStyle(
                      color: Color(0xff19769F),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Padding(padding: EdgeInsets.all(5.0)),

                  const Text(
                    'You\'ve successfully completed your registration.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 100.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  (userType == "Doctor")
                      ? Get.offNamed(doctorsMainScreen)
                      : (userType == "Individual")
                      ? Get.offNamed(selectDoctorScreen)
                      : (userType == "Hospital")
                      ? Get.offNamed(hospitalDashBoardScreen)
                      : Get.offNamed(pharmacyDashBoardScreen);
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
                    gradient: const LinearGradient(
                      colors: [Color(0xff19769F), Color(0xff35D8A6)],
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 0.0,
                  ),
                  child: const Text(
                    'Ok',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
