import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes/app_route_names.dart';

class BoardingOneScreen extends StatelessWidget {
  const BoardingOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.only(
          left: 40.0,
          top: 30.0,
          right: 40.0,
          bottom: 70.0,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background_image_cropped.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "images/app_logo.png",
              height: 180,
              width: 180,
            ),
            ElevatedButton(
              onPressed: (){
                Get.offNamed(boardingTwoScreen);
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
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
