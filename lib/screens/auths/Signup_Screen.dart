import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/http/Network_Handlers.dart';
import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/screens/auths/Login_Screen.dart';
import 'package:hepaloop/utils/App_SnackBar.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //  Global Keys.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //  Form Key.

  //  Internal Variables.
  String _fullName = "";
  String _email = "";
  String _mobileNumber = "";
  String _password = "";
  String _confirmPassword = "";
  String _selectedUser = '';
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _isLoading = false;
  String _messageType = 'Fail';
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  //  Instantiate the AppSnackBar Class.
  AppSnackBar _appSnackBar = AppSnackBar();

  //  Instantiate the NetworkHandler Class.
  NetworkHandler _networkHandler = NetworkHandler();

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
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),

      //  Body.
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  HepaLoop Title.
            Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 15.0),
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

            //  SignUp Form.
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: ListView(
                  children: [
                    Text(
                      'SignUp',
                      style: TextStyle(
                        color: Color(0xff19769F),
                        fontSize: 26.0,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    //  Form.
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _fullName = value;
                        });
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Full name is required.'),
                        MinLengthValidator(6,
                            errorText:
                                'Full name must not be less than 6 characters.')
                      ]),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

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
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _mobileNumber = value;
                        });
                      },
                      validator: RequiredValidator(
                          errorText: 'Mobile number is required.'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Password is required'),
                        MinLengthValidator(8,
                            errorText:
                                'Password must be at least 8 digits long'),
                        PatternValidator(r'^[a-zA-Z0-9]{6,30}$',
                            errorText:
                                'Passwords must have at least one special character')
                      ]),
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
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value;
                        });
                      },
                      validator: (value) =>
                          MatchValidator(errorText: 'Password do not match.')
                              .validateMatch(_password, _confirmPassword),
                      obscureText: _hideConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hideConfirmPassword = !_hideConfirmPassword;
                            });
                          },
                          icon: Icon(_hideConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    DropdownButtonFormField(
                      validator: (value) => (value == null)
                          ? ('Please select a user type.')
                          : (null),
                      items: [
                        'Doctor',
                        'Patient',
                        'Pharmacy',
                      ].map((String userType) {
                        return DropdownMenuItem(
                          child: Text(userType),
                          value: userType,
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
                      onChanged: (String selectedValue) {
                        setState(() {
                          _selectedUser = selectedValue;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),

            //  SignUp Button.
            Container(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: RaisedButton(
                onPressed: () {
                  _signUpUser();
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
                            colors: [Color(0xff19769F), Color(0xff35D8A6)],
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 0.0,
                        ),
                        child: (Text(
                          'SignUp',
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
                            colors: [Color(0xff19769F), Color(0xff35D8A6)],
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
            ),

            //  Don't have and Account.
            Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an Account?',
                    style: TextStyle(
                      color: Color(0xff95989A),
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  InkWell(
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                    },
                    child: Text(
                      (_isLoading) ? 'Please wait...' : 'Login',
                      style: TextStyle(
                        color: Colors.blue,
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
    );
  }

  //  SignUp a User.
  Future _signUpUser() async {
    //  Validate the Form before sending.
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      //  Assign the url based on the type of user that is logged in.
      var url = (_selectedUser == 'Doctor')
          ? signUpDoctorRoute
          : (_selectedUser == 'Patient')
              ? signUpPatientRoute
              : signUpPharmacyRoute;

      //  Assign the Login bodies based on the type of user that is logged in.
      Map<String, String> body = (_selectedUser == 'Doctor')
          ? ({
              'doctors_name': _fullName,
              'doctors_email': _email,
              'doctors_phone': _mobileNumber,
              'doctors_password': _password,
              'doctors_confirmPassword': _password,
              'user_type': 'Doctor',
            })
          : (_selectedUser == 'Patient')
              ? ({
                  'patients_name': _fullName,
                  'patients_email': _email,
                  'patients_phone': _mobileNumber,
                  'patients_password': _password,
                  'patients_confirmPassword': _password,
                  'user_type': 'Patient',
                })
              : ({
                  'pharmacy_name': _fullName,
                  'pharmacy_email': _email,
                  'pharmacy_phone': _mobileNumber,
                  'pharmacy_password': _password,
                  'pharmacy_confirmPassword': _password,
                  'user_type': 'Pharmacy',
                });

      //  Calling the Method that makes the network call.
      Response response = await _networkHandler.signUpUser(url, body);

      //  Decode the "response.dody" to get the body of the response.
      var responseBody = jsonDecode(response.body);

      var isSuccess = responseBody['success'];

      if (isSuccess) {
        setState(() {
          _isLoading = false;
          _messageType = 'Success';
        });

        //  Now extract the "data" object from it.
        var responseData = responseBody['data'];

        /*
       *  Now it's time to check the user_type and convert it to Drt Object using
       *  the Exact Model Cass suitable for it.
       * */
        if (_selectedUser == 'Doctor') {
          var doctorData = responseData['doctor'];

          Map<String, dynamic> _argumentPayload = {
            "id": doctorData['id'],
            'message': responseBody['message'],
            'token': doctorData['token'],
          };

          //  Navigate to the UpdateDoctorsAddressScreen.
          Navigator.pushReplacementNamed(
            context,
            updateDoctorBioDataScreen,
            arguments: _argumentPayload,
          );
        } else if (_selectedUser == 'Patient') {
          var patientData = responseData['patient'];

          Map<String, dynamic> _argumentPayload = {
            'id': patientData['id'],
            'message': responseBody['message'],
            'token': patientData['token'],
          };

          //  Navigate to the UpdatePatientAddressScreen.
          Navigator.pushNamed(
            context,
            updatePatientBioDataScreen,
            arguments: _argumentPayload,
          );
        } else {
          var pharmacyData = responseData['pharmacy'];

          Map<String, dynamic> _argumentPayload = {
            "id": pharmacyData['id'],
            'message': responseBody['message']
          };

          //  Navigate to the UpdatePatientAddressScreen.
          Navigator.pushReplacementNamed(
            context,
            updatePharmacyAddressScreen,
            arguments: _argumentPayload,
          );
        }
      } else {
        setState(() {
          _isLoading = false;
          _messageType = 'Error';
        });

        //  Show SnackBar.
        _scaffoldKey.currentState.showSnackBar(
          _appSnackBar.snackBar(
              'Oops!!! ${responseBody['message']}', _messageType),
        );
      }
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
        _isLoading = false;
      });
    }
  }
}
