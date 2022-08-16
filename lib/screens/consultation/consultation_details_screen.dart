import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hepaloop/models/consultation_model.dart';
import 'package:hepaloop/routes/app_routes/app_route_names.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/consultation_state_controller.dart';

class ConsultationDetailScreen extends StatelessWidget {
  ConsultationDetailScreen({Key? key}) : super(key: key);

  final ConsultationStateController _consultationStateController = Get.find<ConsultationStateController>();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //  App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xff19769F),
        // backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 100.0,
          padding: const EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  // color: Colors.black54,
                  color: Colors.white,
                  icon: const Icon(Iconsax.arrow_left_2),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ),
              ),

              const Text(
                "Consultation Details",
                style: TextStyle(
                  // color: Color(0xff19769F),
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 40.0,
                width: 40.0,
              ),
            ],
          ),
        ),
      ),

      //  Body
      body: GetBuilder<ConsultationStateController>(builder: (controller) {
        return (controller.consultationSender != null) ?
        Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100)
                          ),
                          color: Color(0xff19769F),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60.0),

                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.consultationSender!["name"],
                                      style: const TextStyle(
                                          color: Color(0xff19769F),
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),

                                    const SizedBox(height: 15.0),


                                    //  Gender and Age
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Gender:",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                controller.consultationSender!["gender"],
                                                style: const TextStyle(
                                                    color: Color(0xff19769F),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Age:",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                controller.consultationSender!["age"].toString(),
                                                style: const TextStyle(
                                                    color: Color(0xff19769F),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 15.0),

                                    //  Location
                                    Row(
                                      children: [
                                        const Text(
                                          "Location:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),

                                        const SizedBox(width: 10.0,),

                                        Text(
                                          controller.consultationSender!["city"],
                                          style: const TextStyle(
                                              color: Color(0xff19769F),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 15.0),

                                    //  Address
                                    Row(
                                      children: [
                                        const Text(
                                          "Address:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),

                                        const SizedBox(width: 10.0,),

                                        Text(
                                          controller.consultationSender!["address"],
                                          style: const TextStyle(
                                              color: Color(0xff19769F),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),


                            //  Accept and Decline Buttons.
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextButton(
                                    onPressed: () {
                                      controller.updateConsultationRequest("rejected");
                                      Get.offNamed(doctorsMainScreen);
                                    },
                                    child: Text(
                                      "DECLINE",
                                      style: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red.withOpacity(0.2),
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10.0),

                                Expanded(
                                  flex: 3,
                                  child: TextButton(
                                    onPressed: () {
                                      controller.updateConsultationRequest("accepted");
                                      Get.offNamed(doctorsMainScreen);
                                    },
                                    child: Ink(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.0),
                                        gradient: const LinearGradient(
                                            colors: [Color(0xff19769F), Color(0xff35D8A6)]
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 0.0,
                                      ),
                                      child: const Text(
                                        "ACCEPT",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),

            Positioned(
              // left: 20.0, right: 0.0, top: 150.0, bottom: 0.0,
              height: 160.0,
              width: 110.0,
              left: 50.0,
              top: 70.0,
              child: Container(
                height: 150.0,
                width: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 5.0,
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                  image: DecorationImage(
                      image: (controller.consultationSender!["picture"]!.isNotEmpty) ?
                      NetworkImage(_consultationStateController.consultationSender!["picture"]!) :
                      const AssetImage('images/profile_avatar.png')  as ImageProvider,
                      fit: BoxFit.cover
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              ),
            ),
          ],
        ) :
        const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
            value: 5.0,
          ),
        );
      }),
    );
  }
}
