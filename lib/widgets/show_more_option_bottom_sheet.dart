import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hepaloop/states/individual_state_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../routes/app_routes/app_route_names.dart';
import '../states/doctor_state_controller.dart';
import '../states/notification_state_controller.dart';

class ShowMoreOptionBottomSheet {

  static void showMoreOptionBottomSheet (String userType) {
    Get.bottomSheet(
      Container(
        height: 250.0,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child:
        Column(
          children: [
            //  Title.
            const Expanded(
              flex: 1,
              child: Text(
                'More',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  //  Notification
                  InkWell(
                    onTap: () {
                      print("Selected::: NOTIFICATION");
                      Get.back(); //  To Automatically Close the BottomSheet.
                      Get.toNamed(notificationScreen);
                    },
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            const Icon(
                              Iconsax.notification_status,
                              color: Color(0xff19769F),
                              size: 20.0,
                            ),
                            GetBuilder<NotificationStateController>(builder: (controller) {
                              return Visibility(
                                visible: controller.isPendingNotification,
                                child: Positioned(
                                  right: 0.5,
                                  bottom: 12.0,
                                  child: Container(
                                    height: 7.5,
                                    width: 7.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                        const SizedBox(width: 15.0),
                        const Text(
                          "Notification",
                          style: TextStyle(
                              color: Color(0xff19769F),
                              fontSize: 15.0
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),


                  //  Settings
                  InkWell(
                    onTap: () {
                      print("Selected::: SETTINGS");
                      Get.back();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Iconsax.setting_2,
                          color: Color(0xff19769F),
                          size: 20.0,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          "Settings",
                          style: TextStyle(
                              color: Color(0xff19769F),
                              fontSize: 15.0
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  //  Profile
                  InkWell(
                    onTap: () {
                      print("Selected::: PROFILE");
                      Get.back();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Iconsax.user_octagon,
                          color: Color(0xff19769F),
                          size: 20.0,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: Color(0xff19769F),
                              fontSize: 15.0
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  const Divider(),
                  const SizedBox(height: 10.0),

                  //  Logout
                  InkWell(
                    focusColor: Colors.red,
                    onTap: () {
                      print("Selected::: LOGOUT");
                      Get.back();
                      (userType == "Doctor") ? (
                          Get.find<DoctorStateController>().logoutDoctor()
                      ) : (userType == "Individual") ? (
                          Get.find<IndividualStateController>().logoutDoctor()
                      ) : (userType == "Individual") ? (
                          null
                      ) : (
                          null
                      );

                    },
                    child: Row(
                      children: const [
                        Icon(
                          Iconsax.logout,
                          color: Color(0xff19769F),
                          size: 20.0,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                              color: Color(0xff19769F),
                              fontSize: 15.0
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}