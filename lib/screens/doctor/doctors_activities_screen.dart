import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DoctorsActivitiesScreen extends StatelessWidget {
  DoctorsActivitiesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> activityList = List.generate(
    7,
    (index) => {
      "id": index,
      "activityType": "Call",
      "activityTime": "10:30 AM",
      "activityAvatar": "images/activity.png",
    },
  );

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
                "Activities",
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

      body: ListView.builder(
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
    );
  }
}
