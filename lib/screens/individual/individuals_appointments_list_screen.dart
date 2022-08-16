import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hepaloop/routes/app_routes/app_route_names.dart';
import 'package:iconsax/iconsax.dart';

class IndividualsAppointmentListScreen extends StatelessWidget {
  final bool isFromBottomSheet;

  IndividualsAppointmentListScreen(this.isFromBottomSheet, {Key? key}) : super(key: key);

  /*
  //  Severity
  'Not too severe',
  'Severe',
  'Too severe',
  'Excessively severe',

  //  Venue
  'Audio call',
  'Video call',
  'Hospital visit',
  */

  final List<Map<String, dynamic>> appointmentList = [
    {
      "patientName": "Mary Abot",
      "time": "01 April 2022, 8:00AM",
      "type": "Checkup",
      "venue": "Video call",
      "picture": "images/activities_images/health_checkup.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "01 April 2022, 8:00AM",
      "type": "Vaccination",
      "venue": "Hospital Visit",
      "picture": "images/activities_images/health_vaccination.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "01 April 2022, 8:00AM",
      "type": "Physiotherapy",
      "venue": "Video call",
      "picture": "images/activities_images/health_physiotherapy.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "01 April 2022, 8:00AM",
      "type": "Antenatal",
      "venue": "Audio call",
      "picture": "images/activities_images/pregnancy_trimester_checkups.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "01 April 2022, 8:00AM",
      "type": "Anything",
      "picture": "images/activities_images/sports_physio.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //  App Bar
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        // backgroundColor: Colors.white10,
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
                child: (!isFromBottomSheet) ?
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.black54,
                  icon: const Icon(Iconsax.arrow_left_2),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ) :
                null,
              ),

              const Text(
                "Appointments",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
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

      //  App Body
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
        child: ListView.builder(
          itemCount: appointmentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5.0,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                // height: Get.height - ((Get.height / 2) + 160),
                width: Get.width,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(appointmentList[index]["picture"]),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appointmentList[index]["type"],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "with:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              appointmentList[index]["patientName"],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,),

                    const Divider(height: 5.0,),
                    const SizedBox(height: 10.0,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date & Time:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 7.0),
                            Text(
                              appointmentList[index]["time"],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: () {
                            Get.toNamed(doctorsAppointmentDetailScreen);
                          },
                          child: Text(
                            "Detail",
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            individualsAppointmentBookingScreen,
            arguments: {
              "isFromAddAppointmentFAB": true,
            }
          );
        },
        backgroundColor: const Color(0xff19769F),
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
