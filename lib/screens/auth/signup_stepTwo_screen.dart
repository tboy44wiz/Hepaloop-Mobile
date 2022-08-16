import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

import '../../states/auth_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';
import '../../routes/app_routes/app_route_names.dart';

class SignUpStepTwoScreen extends StatelessWidget {
  SignUpStepTwoScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.find<AuthStateController>();
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _authStateController.getCountries();
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
                  color: const Color(0xff19769F),
                ),
              ),
              const Text(
                "Address",
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
      body: GetBuilder<AuthStateController>(builder: (controller) {
        return BlurryModalProgressHUD(
          inAsyncCall: _authStateController.isLoading,
          child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Form(
                key: _formKey,
                autovalidateMode: controller.autoValidateMode,
                child: ListView(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        controller.updateAddress(value);
                      },
                      validator: RequiredValidator(errorText: 'Address is required.'),
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                        hintText: 'Address',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(9.0)),

                    //  Country
                    DropdownSearch<String>(
                      items: controller.countries,
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      validator: (value) => (value == null)
                          ? ('Please select your country.')
                          : (null),
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        hintText: 'Country',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      onChanged: (value) {
                        controller.updateCountry(value!);
                        controller.getStates(controller.country);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(9.0)),

                    //  State
                    DropdownSearch<String>(
                      items: controller.states,
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      validator: (value) => (value == null)
                          ? ('State is required.')
                          : (null),
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        hintText: 'State',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      onChanged: (value) {
                        controller.updateState(value!);
                        controller.getCities(controller.state);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(9.0)),

                    //  City
                    DropdownSearch<String>(
                      items: controller.cities,
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      validator: (value) => (value == null)
                          ? ('City is required.')
                          : (null),
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        hintText: 'Select your city',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      onChanged: (value) {
                        controller.updateCity(value!);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(9.0)),

                    //  Next Button.
                    ElevatedButton(
                      onPressed: () {
                        // controller.signupUser();
                        (_formKey.currentState!.validate()) ? (
                        controller.signupUser()
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
                          borderRadius: BorderRadius.circular(50.0),
                        ),
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
                          (!controller.isLoading) ? 'Next' : 'Please wait...',
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
                ),
              )
          ),
        );
      }),
    );
  }
}
