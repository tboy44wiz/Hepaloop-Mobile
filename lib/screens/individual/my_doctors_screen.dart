import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hepaloop/routes/app_routes/app_route_names.dart';
import 'package:hepaloop/states/doctor_state_controller.dart';
import 'package:hepaloop/states/individual_state_controller.dart';
import 'package:iconsax/iconsax.dart';

class MyDoctorsScreen extends StatelessWidget {
  MyDoctorsScreen({Key? key}) : super(key: key);

  final IndividualStateController _individualStateController = Get.find<IndividualStateController>();

  @override
  Widget build(BuildContext context) {
    print("INDIVIDUAL222::: ${_individualStateController.individual.token}");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // _individualStateController.getPatientDoctor();
    });

    return Scaffold(
      //  App Bar
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: 100.0,
          padding: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  onPressed: () { Get.back(); },
                  icon: const Icon(Iconsax.arrow_left_2),
                  color: Colors.black54,
                ),
              ),

              const Text(
                "My Doctors",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 40.0,
                width: 40.0,
                child: GetBuilder<IndividualStateController>(
                    builder: (controller) {
                      return (controller.viewType == "GridView") ?
                      IconButton(
                        onPressed: () {
                          controller.updateViewType("ListView");
                        },
                        color: Colors.black54,
                        icon: const Icon(Iconsax.menu_1),
                        iconSize: 24.0 ,
                        padding: const EdgeInsets.all(0.0),
                        tooltip: 'Switched to ListView',
                      ) :
                      IconButton(
                        onPressed: () {
                          controller.updateViewType("GridView");
                        },
                        color: Colors.black54,
                        icon: const Icon(Iconsax.element_3),
                        iconSize: 25.0,
                        padding: const EdgeInsets.all(0.0),
                        tooltip: 'Switched to GridView',
                      );
                    }),
              ),
            ],
          ),
        ),
      ),

      //  Body
      body: GetBuilder<IndividualStateController>(builder: (controller) {
        return (controller.patientsDoctorList.isNotEmpty) ?
        ((controller.viewType == "GridView") ?
        (
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 2 / 2.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                itemCount: controller.patientsDoctorList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      controller.extractSelectedMyDoctorsData(controller.patientsDoctorList[index].id!);
                      Get.toNamed(myDoctorsDetailScreen);
                    },
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Card(
                          margin: const EdgeInsets.only(top: 25.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const SizedBox(height: 30.0),
                              Text(
                                controller.patientsDoctorList[index].name!.split(" ")[0],
                                style: const TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5.0),

                              Text(
                                // controller.doctorsPatientList[index].address!,
                                (controller.patientsDoctorList[index].address!.length <= 30)
                                    ? controller.patientsDoctorList[index].address!
                                    : controller.patientsDoctorList[index].address!.substring(0, 30) + "...",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10.0),

                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: (controller.patientsDoctorList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.pinkAccent.withOpacity(0.3),
                                ),
                                child: Icon(
                                  (controller.patientsDoctorList[index].gender == "Male")
                                      ? Icons.male
                                      : Icons.female,
                                  color: (controller.patientsDoctorList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.9)
                                      : Colors.pinkAccent.withOpacity(0.8),
                                  size: 25.0,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          right: 0.0,
                          top: 0.0,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(controller.patientsDoctorList[index].picture!),
                              backgroundColor: Colors.grey,
                              radius: 32.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
        ) :
        (
            ListView.builder(
              padding: const EdgeInsets.only(top: 20.0),
              itemCount: controller.patientsDoctorList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    controller.extractSelectedMyDoctorsData(controller.patientsDoctorList[index].id!);
                    Get.toNamed(myDoctorsDetailScreen);
                  },
                  child: Container(
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
                          backgroundImage: NetworkImage(controller.patientsDoctorList[index].picture!),
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
                                controller.patientsDoctorList[index].name!,
                                style: const TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                // controller.patientsDoctorList[index].address!,
                                (controller.patientsDoctorList[index].address!.length <= 30)
                                    ? controller.patientsDoctorList[index].address!
                                    : controller.patientsDoctorList[index].address!.substring(0, 30) + "...",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Gender",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 3.0),
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: (controller.patientsDoctorList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.pinkAccent.withOpacity(0.3),
                                ),
                                child: Icon(
                                  (controller.patientsDoctorList[index].gender == "Male")
                                      ? Icons.male
                                      : Icons.female,
                                  color: (controller.patientsDoctorList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.9)
                                      : Colors.pinkAccent.withOpacity(0.8),
                                  size: 25.0,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
        )) :
        const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
            value: 5.0,
          ),
        );
      }),

      //  Bottom Navigation
      /*bottomNavigationBar: BottomAppBar(
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
                    Get.offNamed(individualDashBoardScreen);
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Iconsax.home,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5.0),

                      Text(
                        "Dashboard",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: Get.width / 5,
                ),

                TextButton(
                  onPressed: () {
                    controller.onBottomAppBarItemTapped(1);
                    // Get.offNamed(individualDashBoardScreen);
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Iconsax.activity,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5.0),

                      Text(
                        "Activity",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),*/

      //  Add Doctor FAB
      floatingActionButton: GetBuilder<IndividualStateController>(builder: ((controller) {
        return FloatingActionButton(
          onPressed: () {
            Map<String, dynamic> selectedDoctorData = {
              "name": controller.individual.name,
              "picture": controller.individual.picture,
            };
            Get.toNamed(selectDoctorScreen, arguments: selectedDoctorData);
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff19769F), Color(0xff35D8A6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.profile_add,
              color: Colors.white,
              size: 34.0,
            ),
          ),
        );
      })),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
