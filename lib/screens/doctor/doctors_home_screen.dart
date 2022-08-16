import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/doctor_state_controller.dart';
import '../../routes/app_routes/app_route_names.dart';


class DoctorsHomeScreen extends StatelessWidget {
  DoctorsHomeScreen({Key? key}) : super(key: key);

  final DoctorStateController _doctorStateController = Get.find<DoctorStateController>();

  final List<Map<String, dynamic>> upcomingScheduleList = [
    {
      "patientName": "Mary Abot",
      "time": "10:00 AM",
      "type": "Checkup",
      "picture": "images/activities_images/health_checkup.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "10:00 AM",
      "type": "Vaccination",
      "picture": "images/activities_images/health_vaccination.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "10:00 AM",
      "type": "Physiotherapy",
      "picture": "images/activities_images/health_physiotherapy.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "10:00 AM",
      "type": "Antenatal",
      "picture": "images/activities_images/pregnancy_trimester_checkups.jpg"
    },
    {
      "patientName": "Mary Abot",
      "time": "10:00 AM",
      "type": "Anything",
      "picture": "images/activities_images/sports_physio.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // _doctorStateController.getDoctorPatient();
    });

    return Scaffold(

      // Body.
      body: GetBuilder<DoctorStateController>(builder: (controller) {
          return (controller.doctor.name != null) ?
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: Get.width,
                ),

                //  Welcome message with Avatar.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome,",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          controller.doctor.name!,
                          style: const TextStyle(
                            color: Color(0xff19769F),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.0),
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(controller.doctor.picture!),
                            fit: BoxFit.cover,
                          )),
                      child: null,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                Expanded(
                  flex: 1,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 10.0),
                    children: [
                      SizedBox(
                        height: 210.0,
                        width: Get.width,
                        child: Card(
                          elevation: 5.0,
                          shadowColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    gradient: LinearGradient(
                                        colors: [Color(0xff19769F), Color(0xff35D8A6)]
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Blood Sugar Reading",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Iconsax.clock5,
                                            color: Colors.white70,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "01 April 2022, 8:00AM",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40.0,
                                                width: 40.0,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.blue,
                                                    image: DecorationImage(
                                                      image: NetworkImage(controller.doctor.picture!),
                                                      fit: BoxFit.cover,
                                                    )),
                                                child: null,
                                              ),
                                              const SizedBox(width: 10.0,),

                                              Text(
                                                controller.doctor.name!,
                                                style: const TextStyle(
                                                  color: Color(0xff19769F),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const Icon(
                                            Iconsax.attach_square,
                                            // Icons.attach_file_rounded,
                                            color: Colors.teal,
                                            size: 19.0,
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 15.0,),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
                                                Get.toNamed(individualsBloodSugarReadingScreen,);
                                              },
                                              child: Text(
                                                "View Reading",
                                                style: TextStyle(
                                                    color: Colors.teal[700],
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.teal.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15.0),

                      //  Upcoming Appointments.
                      Card(
                        elevation: 5.0,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Upcoming Appointments",
                                    style: TextStyle(
                                      color: Color(0xff19769F),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        doctorsAppointmentScreen,
                                        arguments: {
                                          "isFromBottomSheet": false,
                                        }
                                      );
                                    },
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                          color: Color(0xff19769F),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20.0),

                              SizedBox(
                                height: 150.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(doctorsAppointmentDetailScreen);
                                      },
                                      child: Card(
                                        elevation: 3.0,
                                        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 9.0, 5.0),
                                        shadowColor: Colors.black38,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 80.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  image: DecorationImage(
                                                    image: AssetImage(upcomingScheduleList[index]["picture"]),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),

                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        upcomingScheduleList[index]["type"],
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                      const SizedBox(height: 3.0),
                                                      Text(
                                                        "with: ${upcomingScheduleList[index]["patientName"]}",
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ) :
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
              value: 5.0,
            ),
          );
        }
      ),
    );
  }
}
