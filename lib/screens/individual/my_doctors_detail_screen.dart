import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/individual_state_controller.dart';

class MyDoctorsDetailScreen extends StatelessWidget {
  MyDoctorsDetailScreen({Key? key}) : super(key: key);

  final IndividualStateController _individualStateController = Get.find<IndividualStateController>();

  final List<Map<String, dynamic>> activityList = List.generate(
      3, (index) => {
    "id": index,
    "activityType": "Call",
    "activityTime": DateFormat('dd-MM-yyyy').format(DateTime.now()),
    "activityAvatar": "images/activity.png",
  });

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
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.black54,
                  icon: const Icon(Iconsax.arrow_left_2),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ),
              ),

              const Text(
                "Doctor",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  onPressed: () {  },
                  icon: const Icon(Icons.more_vert),
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),

      //  Body
      body: ListView(
        children: [
          Container(
            height: Get.height - 170,
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //  Doctors details top part.
                  SizedBox(
                    height: 200.0,
                    width: Get.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Doctors avatar
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 190.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: (_individualStateController.doctor.picture!.isNotEmpty) ?
                                NetworkImage(_individualStateController.doctor.picture!) :
                                const AssetImage('images/profile_avatar.png')  as ImageProvider,
                                fit: BoxFit.cover
                              )
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                          ),
                        ),
                        const SizedBox(width: 15.0),

                        //  Doctors name, rating and patients
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: Get.height,
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr ${_individualStateController.doctor.name}",
                                        style: const TextStyle(
                                          color: Color(0xff19769F),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${_individualStateController.doctor.specialty}",
                                        style: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                //  Doctors' Rating.
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 55.0,
                                      width: 55.0,
                                      child: Card(
                                        elevation: 0.0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Iconsax.star,
                                          color: Colors.amber,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Rating",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "${_individualStateController.doctor.rating}",
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2.0),

                                //  Number of Patients.
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 55.0,
                                      width: 55.0,
                                      child: Card(
                                        elevation: 0.0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          // EvaIcons.people,
                                          Iconsax.profile_2user,
                                          color: Colors.blue,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: const [
                                        Text("Patients",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text("100+",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  //  Doctors details bottom part.
                  Flexible(
                    child: Card(
                      elevation: 0.0,
                      shadowColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  Biography.
                            const Text(
                              "Biography",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text((_individualStateController.doctor.bioInfo!.length > 1000) ?
                            (_individualStateController.doctor.bioInfo!.replaceRange(100, 123, "... Read more.")) :
                            (_individualStateController.doctor.bioInfo!),
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),

                            const SizedBox(height: 20.0),

                            //  Location Map.
                            const Text("Location",
                              style: TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              height: 150.0,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey,
                                  image: const DecorationImage(
                                      image: AssetImage("images/google_map.png"),
                                      fit: BoxFit.cover,
                                  ),
                              ),
                              child: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  //  Activities.
                  Flexible(
                    child: Card(
                      elevation: 0.0,
                      shadowColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Activities",
                                  style: TextStyle(
                                    color: Color(0xff19769F),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "See all",
                                    style: TextStyle(
                                        color: Color(0xff19769F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 170.0,
                              width: Get.context!.width,
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListView.builder(
                                itemCount: activityList.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    color: Colors.grey[100],
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                              activityList[0]["activityAvatar"],
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                activityList[0]["activityType"],
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                activityList[0]["activityTime"],
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                padding: const EdgeInsets.all(0.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  Book appointment button..
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.grey[100],
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 30.0,
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () => {
                  Get.toNamed(individualsAppointmentBookingScreen)
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: Ink(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff19769F), Color(0xff35D8A6)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 0.0,
                  ),
                  child: const Text(
                    'Book Appointment',
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
    );
  }
}
