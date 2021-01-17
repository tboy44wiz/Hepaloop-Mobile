import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//  Import App Packages.
import 'package:hepaloop/http/Network_Handlers.dart';
import 'package:hepaloop/models/Doctor_Model.dart';
import 'package:hepaloop/models/Patient_Model.dart';
import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/utils/App_SnakBar.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //  Internal Variables.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email = '';
  String _password = '';
  String _selectedUser = '';
  bool _hidePassword = true;
  String _messageType = 'Success';
  bool _isLoading = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  //  Instantiate the AppSnackBar Class.
  AppSnackBar _appSnackBar = AppSnackBar();

  //  Instantiate the NetworkHandler Class.
  NetworkHandler _networkHandler = NetworkHandler();

  //  Custom SnackBar.
  SnackBar _snackBar(String toastMessage) {
    return SnackBar(
      content: Text(
        toastMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:
          (_messageType == 'Success') ? (Colors.green[200]) : (Colors.red[300]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back_ios_rounded),
          iconSize: 28.0,
          color: Colors.black45,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),

      //  Body.
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  HepaLoop Title.
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Hepaloop',
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontFamily: 'GothamRounded',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            //  Login Form.
            Container(
              height: (MediaQuery.of(context).size.height) - 130,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),

              //  Form.
              child: Form(
                autovalidateMode: _autoValidateMode,
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff19769F),
                        fontSize: 26.0,
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    //  Text Fields.
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required.'),
                        EmailValidator(errorText: 'Please enter a valid email.')
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 15.0),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator:
                          RequiredValidator(errorText: 'Password is required.'),
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: Icon(_hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),

                    DropdownButtonFormField<String>(
                      // value: _selectedUser,
                      validator: (value) => (value == null)
                          ? ('Please select a user type.')
                          : (null),
                      items: <String>[
                        'Doctor',
                        'Patient',
                        'Pharmacy',
                      ].map((userType) {
                        return DropdownMenuItem(
                          value: userType,
                          child: Text(userType),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                          hintText: 'Select User Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 7.0,
                            horizontal: 15.0,
                          )),
                      onChanged: (selectedValue) {
                        setState(() {
                          _selectedUser = selectedValue;
                        });
                      },
                    ),

                    Padding(padding: EdgeInsets.all(7.0)),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                shape: BoxShape.circle,
                              ),
                              margin: EdgeInsets.only(right: 10.0),
                            ),
                            Text(
                              "Remember",
                              style: TextStyle(
                                color: Color(0xff95989A),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),*/
                        InkWell(
                          onTap: () => {},
                          child: Text(
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

                    Padding(padding: EdgeInsets.all(7.0)),

                    //  Login Button.
                    RaisedButton(
                      onPressed: () {
                        _loginUser();
                      },
                      elevation: 5.0,
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: (!_isLoading)
                          ? Ink(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff19769F),
                                    Color(0xff35D8A6)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 0.0,
                              ),
                              child: (Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          : Ink(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff19769F),
                                    Color(0xff35D8A6)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 8.5,
                                horizontal: 0.0,
                              ),
                              child: (Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                    width: 25.0,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(7.0)),
                                  Text(
                                    'Please wait...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                            ),
                    ),

                    Padding(padding: EdgeInsets.all(5.0)),

                    //  OR.
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Color(0xff95989A),
                          fontSize: 16.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(5.0)),

                    //  Google and FaceBook Button.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: OutlineButton(
                            onPressed: () => {},
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 0.0,
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
                                Padding(padding: EdgeInsets.all(8.0)),
                                Text('Google')
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: OutlineButton(
                            onPressed: () => {},
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 0.0,
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
                                Padding(padding: EdgeInsets.all(8.0)),
                                Text('Facebook')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    //  Don't have and Account.
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an Account?',
                            style: TextStyle(
                              color: Color(0xff95989A),
                              fontSize: 14.0,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          InkWell(
                            onTap: () => {
                              Navigator.pushReplacementNamed(
                                  context, signUpScreen),
                            },
                            child: Text(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Login User.
  Future _loginUser() async {
    //  Validate the Input Fields.
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      //  Assign the url based on the type of user that is logged in.
      var url = (_selectedUser == 'Doctor')
          ? loginDoctorRoute
          : (_selectedUser == 'Patient')
              ? loginPatientRoute
              : loginPharmacyRoute;

      //  Assign the Login bodies based on the type of user that is logged in.
      Map<String, String> body = (_selectedUser == 'Doctor')
          ? ({
              'doctors_email': _email,
              'doctors_password': _password,
              'user_type': 'Doctor',
            })
          : (_selectedUser == 'Patient')
              ? ({
                  'patients_email': _email,
                  'patients_password': _password,
                  'user_type': 'Patient',
                })
              : ({
                  'pharmacy_email': _email,
                  'pharmacy_password': _password,
                  'user_type': 'Pharmacy',
                });

      //  Calling the Method that makes the network cll.
      Response response = await _networkHandler.loginUser(url, body);

      //  Decode the "response.dody" to get the body of the response.
      var responseBody = jsonDecode(response.body);

      var isSuccess = responseBody['success'];

      if (isSuccess) {
        //  Now extract the "data" object from it.
        var responseData = responseBody['data'];

        /*
       *  Now it's time to check the user_type and convert it to Drt Object using
       *  the Exact Model Cass suitable for it.
       * */
        if (_selectedUser == 'Doctor') {
          var doctorData = responseData['doctor'];

          Map<String, dynamic> _formattedDoctorData = {
            'id': doctorData['id'],
            'doctorsName': doctorData['doctors_name'],
            'doctorsEmail': doctorData['doctors_email'],
            'doctorsPhone': doctorData['doctors_phone'],
            'doctorsAvatar': doctorData['doctors_avatar'],
            'loggedInAs': 'Doctor',
            'isLoggedIn': true,
          };

          //  Save to Shared Preferences.
          SharedPreferences _sharedPreferenceStorage =
              await SharedPreferences.getInstance();
          var _encodedDoctorData = jsonEncode(_formattedDoctorData);
          _sharedPreferenceStorage.setString(
              'loggedInUser', _encodedDoctorData);

          //  Get the instance of the Doctors Model Class.
          Doctor _doctor = new Doctor(
            id: doctorData['id'],
            doctorsName: doctorData['doctors_name'],
            doctorsEmail: doctorData['doctors_email'],
            doctorsPhone: doctorData['doctors_phone'],
            doctorsAvatar: doctorData['doctors_avatar'],
          );

          //  Redirect to the Doctor's Dashboard screen.
          Navigator.pushNamedAndRemoveUntil(
              context, doctorDashBoardScreen, (Route<dynamic> route) => false);
        } else if (_selectedUser == 'Patient') {
          var patientData = responseData['patient'];

          //  Save to SHared Preferences.
          SharedPreferences _sharedPreferenceStorage =
              await SharedPreferences.getInstance();
          var encodedPatientData = jsonEncode(patientData);
          _sharedPreferenceStorage.setString('user', encodedPatientData);

          //  Get the instance of the Patients Model Class.
          Patient _patient = new Patient(
            id: patientData['id'],
            patientsName: patientData['patients_name'],
            patientsEmail: patientData['patients_email'],
            patientsAvatar: patientData['patients_avatar'],
          );

          //  Redirect to the Patient's Dashboard screen.
          Navigator.pushReplacementNamed(
            context,
            patientDashBoardScreen,
            arguments: _patient,
          );
        } else {
          var pharmacyData = responseData['pharmacy'];

          //  Save to SHared Preferences.
          SharedPreferences _sharedPreferenceStorage =
              await SharedPreferences.getInstance();
          var encodedPharmacy = jsonEncode(pharmacyData);
          _sharedPreferenceStorage.setString('user', encodedPharmacy);

          //  Redirect to the Pharmacy Dashboard screen.
          Navigator.pushReplacementNamed(context, pharmacyDashBoardScreen);
        }

        //  Reset the state.
        setState(() {
          _isLoading = false;
          _messageType = 'Success';
        });
      } else {
        setState(() {
          _isLoading = false;
          _messageType = 'Error';
        });
        _scaffoldKey.currentState.showSnackBar(
          _appSnackBar.snackBar(
              'Oops!!! ${responseBody['message']}', _messageType),
        );
      }
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
        _isLoading = true;
      });
    }
  }
}
