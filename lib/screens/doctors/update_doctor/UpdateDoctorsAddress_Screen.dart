import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/http/Network_Handlers.dart';
import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:hepaloop/utils/App_SnakBar.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDoctorsAddressScreen extends StatefulWidget {
  final Map<String, dynamic> routeArguments;

  const UpdateDoctorsAddressScreen({Key key, this.routeArguments})
      : super(key: key);

  @override
  _UpdateDoctorsAddressScreenState createState() =>
      _UpdateDoctorsAddressScreenState();
}

class _UpdateDoctorsAddressScreenState
    extends State<UpdateDoctorsAddressScreen> {
  //  Global Keys.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //  Form Key.

  //  State Variables.
  String _id = '';
  String _message = '';
  String _address = '';
  String _city = '';
  String _state = '';
  String _country = '';
  String _messageType = 'Success';
  bool _isLoading = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  //  Instantiate the AppSnackBar Class.
  AppSnackBar _appSnackBar = AppSnackBar();

  //  Instantiate the NetworkHandler Class.
  NetworkHandler _networkHandler = NetworkHandler();

  _getRouteArguments() {
    setState(() {
      _id = widget.routeArguments['id'];
      _message = widget.routeArguments['message'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //  Calling the "_getRouteArguments" function.
    _getRouteArguments();

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Address Details',
                    style: TextStyle(
                      color: Color(0xff19769F),
                      fontFamily: 'GothamRounded',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Finally tell us your address details.',
                    style: TextStyle(
                      color: Color(0xff19769F),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(9.0)),
            Expanded(
              child: Container(
                height: (MediaQuery.of(context).size.height / 1.2) - 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: ListView(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _address = value;
                            });
                          },
                          validator: RequiredValidator(
                              errorText: 'Address is required.'),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 15.0,
                              ),
                              hintText: 'Address'),
                        ),

                        Padding(padding: EdgeInsets.all(9.0)),

                        //  Country
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                          validator: RequiredValidator(
                              errorText: 'Country is required.'),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 15.0,
                            ),
                            hintText: 'Country',
                          ),
                        ),

                        Padding(padding: EdgeInsets.all(9.0)),

                        //  Country
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _state = value;
                            });
                          },
                          validator: RequiredValidator(
                              errorText: 'State is required.'),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 15.0,
                            ),
                            hintText: 'State',
                          ),
                        ),

                        Padding(padding: EdgeInsets.all(9.0)),

                        //  Country
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _city = value;
                            });
                          },
                          validator:
                              RequiredValidator(errorText: 'City is required.'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 15.0,
                            ),
                            hintText: 'City',
                          ),
                        ),
                      ],
                    )),
              ),
            ),

            //  Submit Button.
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    _submitDoctorsAddress();
                  },
                  elevation: 5.0,
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Ink(
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
                    child: Text(
                      (!_isLoading) ? 'Submit' : 'Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
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

  Future _submitDoctorsAddress() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Request Payload.
      Map<String, dynamic> body = {
        'doctors_address': _address,
        'doctors_city': _city,
        'doctors_state': _state,
        'doctors_email': _country,
      };

      //  Get the Token from the Shared Preference.
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      var _userData = _sharedPreferences.getString('user');
      var _decodedUserData = jsonDecode(_userData);
      var _token = _decodedUserData['token'];
      print(_decodedUserData);

      //  Calling the Method that makes the network call.
      Response response = await _networkHandler.updateDoctor(
          updateDoctorRoute, _id, body, _token);

      var responseBody = jsonDecode(response.body);

      var isSuccess = responseBody['success'];
      if (isSuccess) {
        setState(() {
          _isLoading = false;
          _messageType = 'Success';
        });

        //  Show SnackBar.
        _scaffoldKey.currentState.showSnackBar(_appSnackBar.snackBar(
            'Yeah...   Response gone Write...', _messageType));
      }
      setState(() {
        _isLoading = false;
        _messageType = 'Error';
      });

      //  Show SnackBar.
      _scaffoldKey.currentState.showSnackBar(_appSnackBar.snackBar(
          'Yeah...   Response gone Wrong...', _messageType));
    } else {
      setState(() {
        _isLoading = false;
        _messageType = 'Error';
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });

      //  Show SnackBar.
      _scaffoldKey.currentState.showSnackBar(_appSnackBar.snackBar(
          'Oops!!! Validation gone Wrong...', _messageType));
    }
  }
}
