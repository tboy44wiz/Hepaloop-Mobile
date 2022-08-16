import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../services/socketIO_service.dart';
import '../../states/individual_state_controller.dart';

class DoctorsDetailsAndRequestConsultationScreen extends StatelessWidget {
  DoctorsDetailsAndRequestConsultationScreen({Key? key}) : super(key: key);

  final IndividualStateController _individualStateController = Get.find<IndividualStateController>();
  final SocketIOServiceController _socketIOServiceController = Get.put(SocketIOServiceController());

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
            ],
          ),
        ),
      ),

      //  Body
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Center(
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: (_individualStateController.doctor.picture!.isNotEmpty) ?
                        NetworkImage(_individualStateController.doctor.picture!) :
                        const AssetImage('images/profile_avatar.png') as ImageProvider,
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 10.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    //  DOCTORS NAME
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${_individualStateController.doctor.name}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              _individualStateController.doctor.specialty!,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 45.0,
                              width: 45.0,
                              child: TextButton(
                                onPressed: () {},
                                child: Icon(
                                  Iconsax.call,
                                  color: Colors.blue[900],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[300]!.withOpacity(0.7),
                                  padding: const EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5.0)),
                            SizedBox(
                              height: 45.0,
                              width: 45.0,
                              child: TextButton(
                                onPressed: () {},
                                child: Icon(
                                  Iconsax.message,
                                  color: Colors.pinkAccent[400],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent[100]!.withOpacity(0.7),
                                  padding: const EdgeInsets.all(6.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15.0),

                    //  RATING BAR.
                    Row(
                      children: [
                        Text(
                          "${_individualStateController.doctor.rating}.0",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(3.0)),
                        RatingBar.builder(
                          initialRating: double.parse(_individualStateController.doctor.rating!),
                          minRating: 1.0,
                          itemCount: 5,
                          itemSize: 20.0,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => Icon(
                            Iconsax.star1,
                            color: Colors.amber[700]!.withOpacity(0.7),
                            size: 15.0,
                          ),
                          onRatingUpdate: (value){
                            return;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    //  ABOUT
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _individualStateController.doctor.bioInfo!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    //  PATIENTS, EXPERIENCE & RATING.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 60.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[300]!.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Patients",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "68",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(9.0)),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 60.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.orange[200]!.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Experience",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${_individualStateController.yearsOfExperience} yrs",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //  Consultation Button.
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 30.0,
                ),
                color: Colors.white,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => {
                      _individualStateController.createConsultation(_socketIOServiceController),
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
                        'Request Consultation',
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
            ),
          ],
        ),
      ),

      //  Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        // color: Colors.grey[100],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 63.0,
          width: Get.width,
          child: GetBuilder<IndividualStateController>(builder: (controller) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.onBottomAppBarItemTapped(0);
                    // Get.offNamed(individualsDashBoardScreen);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.home,
                        color: (controller.selectedBottomAppBarIndex == 0)
                            ? Colors.teal
                            : Colors.grey,
                      ),
                      const SizedBox(height: 5.0),

                      Text(
                        "Dashboard",
                        style: TextStyle(
                          color: (controller.selectedBottomAppBarIndex == 0)
                              ? Colors.teal
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    controller.onBottomAppBarItemTapped(1);
                    // Get.offNamed(individualDashBoardScreen);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.activity,
                        color: (controller.selectedBottomAppBarIndex == 1)
                            ? Colors.teal
                            : Colors.grey,
                      ),
                      const SizedBox(height: 5.0),

                      Text(
                        "Anything",
                        style: TextStyle(
                          color: (controller.selectedBottomAppBarIndex == 1)
                              ? Colors.teal
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    controller.onBottomAppBarItemTapped(1);
                    // Get.offNamed(individualDashBoardScreen);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.activity,
                        color: (controller.selectedBottomAppBarIndex == 1)
                            ? Colors.teal
                            : Colors.grey,
                      ),
                      const SizedBox(height: 5.0),

                      Text(
                        "Anything",
                        style: TextStyle(
                          color: (controller.selectedBottomAppBarIndex == 1)
                              ? Colors.teal
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
