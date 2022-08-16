import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hepaloop/widgets/show_select_reading_bottom_sheet_widget.dart';

import '../../routes/app_routes/app_route_names.dart';

class IndividualsDashBoardScreen extends StatelessWidget {
  const IndividualsDashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: Get.height,
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40.0,),

          //  First Row.
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () {
                        ShowSelectReadingBottomSheetWidget.showSelectReadingBottomSheetWidget();
                      },
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/first_aid_box.png'),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('Record Details')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.all(10.0)),

                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/send_report.png'),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('HMO')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          //  Second Row.
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () => {
                        Get.toNamed(myDoctorsScreen),
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/doctor_male_avatar.png',
                              height: 70.0,
                            ),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('My Doctors')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.all(10.0)),

                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                            individualsAppointmentListScreen,
                            /*arguments: {
                              "isFromBottomSheet": false,
                            }*/
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/medical_history.png'),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('Appointments')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          //  Third Row.
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/ambulance.png'),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('Emergency')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5.0,
                    shadowColor: const Color(0xffa8ffea).withOpacity(0.7),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa8ffea)),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/pill.png'),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            const Text('Pharmacies')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

