import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class IndividualsAppointmentDetailScreen extends StatelessWidget {
  const IndividualsAppointmentDetailScreen({Key? key}) : super(key: key);

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
                "Appointment Details",
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

      //  Body
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // height: Get.height / 2,
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0),
                child: Column(
                  children: [
                    Stack(
                        children: [
                          Container(
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.green,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  offset: Offset(2.0, 5.0),
                                )
                              ],
                              image: const DecorationImage(
                                  image: AssetImage("images/profile_avatar.png"),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 7.0,
                            right: 0.0,
                            child: Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 15.0),

                    //  Patients Name"
                    const Text(
                      "Patients Name",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Patient's Profile",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),

              // Note Card.
              Card(
                elevation: 5.0,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  // height: Get.height - ((Get.height / 2) + 160),
                  width: Get.width,
                  padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Note:",
                        style: TextStyle(
                          color: Color(0xff19769F),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Type, Venue, Date & Time Card.
              Card(
                elevation: 5.0,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  // height: Get.height - ((Get.height / 2) + 160),
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [

                      // Type & Venue
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Type:",
                                style: TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                "Checkup",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Venue:",
                                style: TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                "Video Call",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 20.0),

                      // Date & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Date:",
                                style: TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                "Tue, 16 April",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Time:",
                                style: TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                "10:30 AM",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),


              //  Cancel & Reschedule Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  //  Cancel
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  //  Reschedule
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reschedule",
                        style: TextStyle(
                            color: Colors.teal[700],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.teal.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 0.0),
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

    );
  }
}