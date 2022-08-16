import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/consultation_state_controller.dart';
import '../../states/notification_state_controller.dart';
import '../../routes/app_routes/app_route_names.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final NotificationStateController _notificationStateController = Get.find<NotificationStateController>();
  // final ConsultationStateController _consultationStateController = Get.put(ConsultationStateController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //  AppBar.
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xff19769F),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.close_square,
              color: Color(0xff19769F),
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),

      //  Body.
      body: Center(
        child: GetBuilder<NotificationStateController>(builder: (controller) {
          return (controller.allNotifications.isNotEmpty) ?
            ListView.builder(
              itemCount: controller.allNotifications.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    controller.updateNotificationInSQFLiteDatabase(controller.allNotifications[index]["id"]);
                    controller.updateNotificationInServer(controller.allNotifications[index]["id"]);
                    // _consultationStateController.getSingleConsultationRequest(controller.allNotifications[index]["refId"], controller.token);
                    Get.toNamed(consultationDetailScreen);
                  },
                  child: Container(
                    height: 75.0,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(controller.allNotifications[index]["senderImage"]),
                          backgroundColor: Colors.grey,
                          radius: 25.0,
                        ),
                        const SizedBox(width: 10.0),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.allNotifications[index]["title"],
                                style: TextStyle(
                                  color: (controller.allNotifications[index]["isDelivered"] == 1)
                                      ? Colors.black45
                                      : const Color(0xff19769F),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                (controller.allNotifications[index]["content"].length <= 40)
                                  ? controller.allNotifications[index]["content"]
                                  : controller.allNotifications[index]["content"].substring(0, 40) + "...",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 60.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.getNotificationTime(
                                  DateTime.parse(controller.allNotifications[index]["createdAt"])
                                ),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10.0,
                                ),
                              ),
                              const SizedBox(height: 5.0),

                              Icon(
                                (controller.allNotifications[index]["type"] == "Consultation")
                                  ? Iconsax.profile_2user
                                  : (controller.allNotifications[index]["type"] == "Appointment")
                                  ? Iconsax.calendar_add
                                  : (controller.allNotifications[index]["type"] == "Chat")
                                  ? Iconsax.messages
                                  : (controller.allNotifications[index]["type"] == "Call")
                                  ? Iconsax.call
                                  : (controller.allNotifications[index]["type"] == "Message")
                                  ? Iconsax.message_text
                                  : (controller.allNotifications[index]["type"] == "Reading")
                                  ? Iconsax.chart_2
                                  : Iconsax.notification,
                                color: (controller.allNotifications[index]["isDelivered"] == 1)
                                    ? Colors.black45
                                    : const Color(0xff19769F),
                                size: 20.0,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ) :
          const Center(
            child: Text(
              "No\nNotification",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
    );
  }
}
