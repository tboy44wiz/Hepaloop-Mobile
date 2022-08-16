import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ShowSelectCallBottomSheetWidget {
  static void showSelectCallBottomSheetWidget() {
    Get.bottomSheet(
      Container(
        height: 150.0,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Choose Call',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.back(); //  To Automatically Close the BottomSheet.
                },
                child: Row(
                  children: const [
                    Icon(Iconsax.call, color: Colors.black45),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Text('Voice Call',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black45,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.back(); //  To Automatically Close the BottomSheet.
                },
                child: Row(
                  children: const [
                    Icon(Iconsax.video, color: Colors.black45),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Text('Video Call',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black45,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}