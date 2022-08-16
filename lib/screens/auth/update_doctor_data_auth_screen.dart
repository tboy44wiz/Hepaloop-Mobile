import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hepaloop/states/auth_state_controller.dart';
import 'package:hepaloop/widgets/app_snackBar_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/doctor_state_controller.dart';
import '../../widgets/show_select_avatar_bottom_sheet_widget.dart';

class UpdateDoctorDataAuthScreen extends StatelessWidget {
  UpdateDoctorDataAuthScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DoctorStateController _doctorStateController = Get.put(DoctorStateController());
  final AuthStateController _authStateController = Get.find<AuthStateController>();
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
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
                  color: const Color(0xff19769F),
                ),
              ),
              const Text(
                "Doctors Data",
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

        //  Body.
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _doctorStateController.autoValidateMode,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<AuthStateController>(builder: (authStateController) {
                  return SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 45.0,
                            backgroundImage: (authStateController.pickedFile != null) ?
                            FileImage(authStateController.pickedFile!) :
                            const AssetImage('images/profile_avatar.png') as ImageProvider,
                          ),
                        ),

                        Positioned(
                          height: 30.0,
                          width: 30.0,
                          top: 65.0,
                          right: 3.0,
                          child: Container(
                            height: 25.0,
                            width: 25.0,
                            decoration: const BoxDecoration(
                              color: Color(0xff19769F),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                ShowSelectAvatarBottomSheetWidget.showSelectAvatarBottomSheet();
                              },
                              color: const Color(0xff19769F),
                              padding: const EdgeInsets.all(8.0),
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                ),
                const Padding(padding: EdgeInsets.all(15.0)),

                GetBuilder<DoctorStateController>(builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  Doctors Gender.
                      DropdownButtonFormField<String>(
                        onChanged: (value) {
                          controller.updateGender(value!);
                        },
                        validator: (value) => (value == null)
                            ? ('Please select yur gender.')
                            : (null),
                        items: <String>['Male', 'Female'].map((eachGender) {
                          return DropdownMenuItem(
                            value: eachGender,
                            child: Text(eachGender),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: 'Select gender',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Doctors Specialty
                      DropdownButtonFormField<String>(
                        onChanged: (value) {
                          controller.updateSpecialty(value!);
                        },
                        validator: (value) => (value == null)
                            ? ('Please select a user type.')
                            : (null),
                        items: controller.specialtyList.map((eachItem) {
                          return DropdownMenuItem(
                            value: eachItem,
                            child: Text(eachItem),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: 'Select your specialty',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Doctors Place of Work (Hospital)
                      TextFormField(
                        onChanged: (value) {
                          controller.updateHospital(value);
                        },
                        validator: RequiredValidator(errorText: 'Hospital is required.'),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 15.0,
                          ),
                          hintText: 'Hospital (Place of work)',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Started Year of Practice (SYOP)
                      TextFormField(
                        onTap: () {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.showDefaultDatePicker();
                        },
                        controller: controller.startingYearOfPracticeEditingController,
                        validator: RequiredValidator(errorText: 'Started year of practice is required.'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 15.0
                          ),
                          hintText: 'Started year of practice',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Doctors Bio Info
                      TextFormField(
                        onChanged: (value) {
                          controller.updateBioInfo(value);
                        },
                        validator: RequiredValidator(errorText: 'Your professional Bio Info is required.'),
                        keyboardType: TextInputType.name,
                        maxLines: 5,
                        maxLength: 140,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          hintText: 'A short professional biography',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Submit Button.
                      ElevatedButton(
                        onPressed: () {
                          (_formKey.currentState!.validate()) ? (
                              controller.createDoctor()
                          ) : ({
                            controller.updateAutoValidateMode(),
                            //  Show SnackBar.
                            _appSnackBar.snackBar('Please fill all the required fields.', 'Error'),
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)
                            )
                        ),
                        child: Ink(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            gradient: const LinearGradient(
                                colors: [Color(0xff19769F), Color(0xff35D8A6)]
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 0.0,
                          ),
                          child: Text(
                            (!controller.isLoading) ? 'Submit' : 'Please wait...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
