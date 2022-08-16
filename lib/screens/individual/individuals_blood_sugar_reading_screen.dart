import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class IndividualsBloodSugarReadingScreen extends StatelessWidget {
  IndividualsBloodSugarReadingScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> appointmentList = [
    {
      "doctorName": "James Bennet",
      "fasting": "4.8",
      "random": "7.1",
      "2Hours": "6.3",
      "unit": "mmol/L",
      "time": "01 April 2022, 8:00AM",
      "doctorsPicture": "images/activities_images/health_checkup.jpg"
    },
    {
      "doctorName": "James Bennet",
      "fasting": "105",
      "random": "7.1",
      "2Hours": "6.3",
      "unit": "mg/dL",
      "time": "01 April 2022, 8:00AM",
      "doctorsPicture": "images/activities_images/health_vaccination.jpg"
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
                "Blood Glucose",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 18.0,
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
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(appointmentList[index]["doctorsPicture"]),
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
                              appointmentList[index]["doctorName"],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              appointmentList[index]["time"],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
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
                              "Reading:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(height: 7.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  appointmentList[index]["fasting"],
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(width: 3.0),
                                Text(
                                  appointmentList[index]["unit"],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "View",
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
        onPressed: () {},
        backgroundColor: const Color(0xff19769F),
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
