import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '../../states/auth_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';
import '../../routes/app_routes/app_route_names.dart';

class SignUpStepOneScreen extends StatelessWidget {
  SignUpStepOneScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.put(AuthStateController());
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
            children: const [
              SizedBox(
                height: 40.0,
                width: 40.0,
              ),
              Text(
                "Sign up",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 40.0,
              ),
            ],
          ),
        ),
      ),

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
          child: GetBuilder<AuthStateController>(builder: (controller) {
            return Form(
              key: _formKey,
              autovalidateMode: controller.autoValidateMode,
              child: ListView(
                children: [
                  DropdownButtonFormField<String>(
                    // value: _selectedUser,
                    validator: (value) => (value == null)
                        ? ('Please select a user type.')
                        : (null),
                    items: <String>[
                      'An Individual',
                      'A Doctor',
                      'A Hospital',
                      'A Pharmacy Outlet',
                    ].map((userType) {
                      return DropdownMenuItem(
                        value: userType,
                        child: Text(userType),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Login as',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                    ),
                    onChanged: (selectedValue) {
                      controller.updateRole(selectedValue!);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(7.0)),

                  Visibility(
                      visible: controller.showFirstAndLastNameTextFormField,
                      child: TextFormField(
                        onChanged: (value) {
                          controller.updateFirstName(value);
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'First name is required.'),
                        ]),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 15.0,
                          ),
                        ),
                      )
                  ),
                  Visibility(
                      visible:
                      controller.showFirstAndLastNameTextFormField,
                      child: const Padding(padding: EdgeInsets.all(9.0))
                  ),

                  Visibility(
                      visible: controller.showFirstAndLastNameTextFormField,
                      child: TextFormField(
                        onChanged: (value) {
                          controller.updateLastName(value);
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Last name is required.'),
                        ]),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                        ),
                      )
                  ),
                  Visibility(
                    visible: controller.showFullNameTextFormField,
                    child: TextFormField(
                      onChanged: (value) {
                        controller.updateFullName(value);
                      },
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Full name is required.'),
                      ]),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),

                  TextFormField(
                    onChanged: (value) {
                      controller.updateEmail(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required.'),
                      EmailValidator(errorText: 'Please enter a valid email.')
                    ]),
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),

                  TextFormField(
                    onChanged: (value) {
                      controller.updatePhoneNumber(value);
                    },
                    validator: RequiredValidator(errorText: 'Mobile number is required.'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),

                  TextFormField(
                    onChanged: (value) {
                      controller.updatePassword(value);
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
                      PatternValidator(r'^[a-zA-Z0-9]{6,30}$', errorText: 'Passwords must have at least one special character')
                    ]),
                    obscureText: controller.hidePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.updateHidePassword();
                        },
                        icon: Icon(controller.hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),

                  TextFormField(
                    onChanged: (value) {
                      controller.updateConfirmPassword(value);
                    },
                    validator: (value) => MatchValidator(errorText: 'Password do not match.')
                        .validateMatch(controller.password, controller.confirmPassword),
                    obscureText: controller.hideConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.updateHideConfirmPassword();
                        },
                        icon: Icon(controller.hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
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

                  //  Next Button.
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(signUpStepTwoScreen);
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
                  const Padding(padding: EdgeInsets.all(9.0)),

                  //  Already have an Account.
                  Container(
                    height: MediaQuery.of(context).size.height / 13,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an Account?',
                          style: TextStyle(
                            color: Color(0xff95989A),
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5.0)),
                        InkWell(
                          onTap: () => {
                            Get.offNamed(loginScreen),
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff19769F),
                              fontSize: 14.0,
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
          ),
        ),
      ),
    );
  }
}
