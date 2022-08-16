import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hepaloop/routes/app_routes/app_route_names.dart';
import 'package:hepaloop/widgets/show_select_call_bottom_sheet_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../states/doctor_state_controller.dart';

class MyPatientDetailScreen extends StatelessWidget {
  MyPatientDetailScreen({Key? key}) : super(key: key);

  final DoctorStateController _doctorStateController = Get.find<DoctorStateController>();

  final List<Map<String, dynamic>> activityList = List.generate(
      3, (index) => {
    "id": index,
    "activityType": "Call",
    "activityTime": "10:30 AM",
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
                "Patient",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(
                height: 40.0,
                width: 40.0,
                /*child: IconButton(
                  onPressed: () {  },
                  icon: const Icon(Icons.more_vert),
                  color: Colors.black54,
                ),*/
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
                  //  Patients details top part.
                  SizedBox(
                    height: 200.0,
                    width: Get.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Patients avatar
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 190.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                                image: DecorationImage(
                                    image: NetworkImage(_doctorStateController.individual.picture!),
                                    fit: BoxFit.cover
                                )
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                          ),
                        ),
                        const SizedBox(width: 15.0),

                        //  Patients name, Gender and Age
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: Get.height,
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _doctorStateController.individual.name!,
                                      style: const TextStyle(
                                        color: Color(0xff19769F),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _doctorStateController.individual.email!,
                                      style: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),


                                //  Patients Gender.
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45.0,
                                      width: 45.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: (_doctorStateController.individual.gender == "Male")
                                            ? Colors.blue.withOpacity(0.3)
                                            : Colors.red.withOpacity(0.3),
                                      ),
                                      child: Icon(
                                        (_doctorStateController.individual.gender == "Male")
                                            ? Icons.male
                                            : Icons.female,
                                        color: (_doctorStateController.individual.gender == "Male")
                                            ? Colors.blue.withOpacity(0.9)
                                            : Colors.red[700],
                                        size: 30.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Gender",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          _doctorStateController.individual.gender!,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15.0),

                                //  Patients Age.
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45.0,
                                      width: 45.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.orangeAccent.withOpacity(0.3),
                                      ),
                                      child: const Icon(
                                        Iconsax.activity,
                                        color: Colors.orange,
                                        size: 25.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Age",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          (_doctorStateController.individual.age!).toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
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

                  //  Address and Location.
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
                              "Address",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text((_doctorStateController.individual.address!.length > 1000) ?
                            (_doctorStateController.individual.address!.replaceRange(100, 123, "... Read more.")) :
                            (_doctorStateController.individual.address!),
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),

                            const SizedBox(height: 20.0),

                            //  Location Map.
                            const Text("Location",
                              style: TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 16.0,
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(doctorsActivitiesScreen);
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 45.0,
                                            width: 45.0,
                                            padding: const EdgeInsets.all(7.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: (activityList[index]["activityType"] == "Call") ?
                                              Colors.orangeAccent.withOpacity(0.3) :
                                              (activityList[index]["activityType"] == "CheckUp") ?
                                              Colors.purpleAccent.withOpacity(0.3) :
                                              (activityList[index]["activityType"] == "Medication") ?
                                              Colors.pinkAccent.withOpacity(0.3) :
                                              Colors.blueAccent.withOpacity(0.3)
                                            ),
                                            child: Image.asset(
                                              activityList[index]["activityAvatar"],
                                              color: (activityList[index]["activityType"] == "Call") ?
                                              Colors.orangeAccent :
                                              (activityList[index]["activityType"] == "CheckUp") ?
                                              Colors.purpleAccent :
                                              (activityList[index]["activityType"] == "Medication") ?
                                              Colors.pinkAccent :
                                              Colors.blueAccent,
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

          //  Call button..

          //  Message and Call Buttons.
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Message",
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10.0),

                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      ShowSelectCallBottomSheetWidget.showSelectCallBottomSheetWidget();
                    },
                    child: Text(
                      "Call",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}
