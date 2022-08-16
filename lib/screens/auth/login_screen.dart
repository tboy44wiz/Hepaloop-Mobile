import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/states/auth_state_controller.dart';

import '../../widgets/app_snackBar_widget.dart';
import '../../routes/app_routes/app_route_names.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppSnackBar _appSnackBar = AppSnackBar();

  final AuthStateController _authStateController = Get.put(AuthStateController());

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
          padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                height: 40.0,
                width: 40.0,
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 24.0,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                          controller.updatePassword(value);
                        },
                        validator: RequiredValidator(errorText: 'Password is required.'),
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => {},
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Login Button.
                      ElevatedButton(
                        onPressed: () {
                          (_formKey.currentState!.validate()) ? (
                              controller.loginUser()
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
                            (!controller.isLoading) ? 'Login' : 'Please wait...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(9.0)),

                      //  Google and FaceBook Button.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: OutlinedButton(
                              onPressed: () => { print("Google...") },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 0.0,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/google.png',
                                    height: 25.0,
                                    width: 25.0,
                                  ),
                                  const Padding(padding: EdgeInsets.all(8.0)),
                                  const Text('Google')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: OutlinedButton(
                              onPressed: () => {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 0.0,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/facebook.png',
                                    height: 25.0,
                                    width: 25.0,
                                  ),
                                  const Padding(padding: EdgeInsets.all(8.0)),
                                  const Text('Facebook')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),

                      //  Don't have an Account.
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an Account?',
                              style: TextStyle(
                                color: Color(0xff95989A),
                                fontSize: 14.0,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5.0)),
                            InkWell(
                              onTap: () {
                                Get.offNamed(signUpStepOneScreen);
                              },
                              child: const Text(
                                'Create Account',
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
      ),
    );
  }
}
