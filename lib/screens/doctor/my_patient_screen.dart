import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/doctor_state_controller.dart';

class MyPatientScreen extends StatelessWidget {
  MyPatientScreen({Key? key}) : super(key: key);

  final DoctorStateController _doctorStateController = Get.find<DoctorStateController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _doctorStateController.getDoctorPatient();
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
                "My Patients",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 40.0,
                width: 40.0,
                child: GetBuilder<DoctorStateController>(
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

      //  App Body.
      body: GetBuilder<DoctorStateController>(builder: (controller) {
        return (controller.doctorsPatientList.isNotEmpty) ?
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
                itemCount: controller.doctorsPatientList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      controller.extractSelectedPatientsData(controller.doctorsPatientList[index].id!);
                      Get.toNamed(myPatientDetailScreen);
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
                                controller.doctorsPatientList[index].name!.split(" ")[0],
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
                                (controller.doctorsPatientList[index].address!.length <= 30)
                                    ? controller.doctorsPatientList[index].address!
                                    : controller.doctorsPatientList[index].address!.substring(0, 30) + "...",
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
                                  color: (controller.doctorsPatientList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.pinkAccent.withOpacity(0.3),
                                ),
                                child: Icon(
                                  (controller.doctorsPatientList[index].gender == "Male")
                                      ? Icons.male
                                      : Icons.female,
                                  color: (controller.doctorsPatientList[index].gender == "Male")
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
                              backgroundImage: NetworkImage(controller.doctorsPatientList[index].picture!),
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
              itemCount: controller.doctorsPatientList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    controller.extractSelectedPatientsData(controller.doctorsPatientList[index].id!);
                    Get.toNamed(myPatientDetailScreen);
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
                          backgroundImage: NetworkImage(controller.doctorsPatientList[index].picture!),
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
                                controller.doctorsPatientList[index].name!,
                                style: const TextStyle(
                                  color: Color(0xff19769F),
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                // controller.doctorsPatientList[index].address!,
                                (controller.doctorsPatientList[index].address!.length <= 30)
                                    ? controller.doctorsPatientList[index].address!
                                    : controller.doctorsPatientList[index].address!.substring(0, 30) + "...",
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
                                  color: (controller.doctorsPatientList[index].gender == "Male")
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.pinkAccent.withOpacity(0.3),
                                ),
                                child: Icon(
                                  (controller.doctorsPatientList[index].gender == "Male")
                                      ? Icons.male
                                      : Icons.female,
                                  color: (controller.doctorsPatientList[index].gender == "Male")
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
    );
  }
}
