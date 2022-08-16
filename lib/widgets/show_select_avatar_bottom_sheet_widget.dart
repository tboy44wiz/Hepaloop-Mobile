import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../states/auth_state_controller.dart';

class ShowSelectAvatarBottomSheetWidget {
  static void showSelectAvatarBottomSheet() {
    Get.bottomSheet(Container(
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
              'Choose photo from:',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xff19769F),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.find<AuthStateController>().takePicture(ImageSource.camera);
                Get.back(); //  To Automatically Close the BottomSheet.
              },
              child: Row(
                children: const [
                  Icon(Icons.camera, color: Colors.black45),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text('Camera',
                      style: TextStyle(
                        fontSize: 19.0,
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
                Get.find<AuthStateController>().takePicture(ImageSource.gallery);
                Get.back(); //  To Automatically Close the BottomSheet.
              },
              child: Row(
                children: const [
                  Icon(Icons.image_rounded, color: Colors.black45),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text('Gallery',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.black45,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}