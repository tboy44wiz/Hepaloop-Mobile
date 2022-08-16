import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/individual_state_controller.dart';

class DoctorsAppointmentBookingScreen extends StatelessWidget {
  DoctorsAppointmentBookingScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],

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
                "Book Appointment",
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
          scrollDirection: Axis.vertical,
          children: [
            //  Appointment Form.
            Card(
              elevation: 5.0,
              shadowColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 15.0,
                ),
                child: Form(
                  // key: _individualStateController.individualAppointmentFormKey,
                  child: Column(
                    children: [
                      //  Reason.
                      TextFormField(
                        onChanged: (value) {},
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText:
                              'Reason for appointment is required.'),
                        ]),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Reason",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 15.0,
                          ),
                        ),
                      ),

                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Severity level.
                      DropdownButtonFormField(
                        onChanged: (selectedValue) {},
                        validator: (value) => (value == null)
                            ? ('Please select a user type.')
                            : (null),
                        items: [
                          'Not too severe',
                          'Severe',
                          'Too severe',
                          'Excessively severe',
                        ].map((String userType) {
                          return DropdownMenuItem(
                            child: Text(userType),
                            value: userType,
                          );
                        }).toList(),
                        decoration: InputDecoration(
                            hintText: 'Severity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                              horizontal: 15.0,
                            )),
                      ),

                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Appointment Means.
                      DropdownButtonFormField(
                        onChanged: (selectedValue) {},
                        validator: (value) => (value == null)
                            ? ('Please select a user type.')
                            : (null),
                        items: [
                          'Audio call',
                          'Video call',
                          'Hospital visit',
                        ].map((String userType) {
                          return DropdownMenuItem(
                            child: Text(userType),
                            value: userType,
                          );
                        }).toList(),
                        decoration: InputDecoration(
                            hintText: 'Appointment channel',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                              horizontal: 15.0,
                            )),
                      ),

                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Appointment date.
                      TextFormField(
                        onTap: () {},
                        // controller: controller.appointmentEditingController,
                        validator: RequiredValidator(
                            errorText: 'Date if birth is required.'),
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: 'Appointment date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 15.0,
                          ),
                        ),
                      ),

                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Appointment time.
                      TextFormField(
                        onTap: () {},
                        // controller: controller.appointmentEditingController,
                        validator: RequiredValidator(
                            errorText: 'Date if birth is required.'),
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: 'Appointment time',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50.0),

            //  Appointment Button.
            Container(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: Ink(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff19769F), Color(0xff35D8A6)],
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
