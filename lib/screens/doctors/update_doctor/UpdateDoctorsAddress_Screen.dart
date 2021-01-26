import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/http/Network_Handlers.dart';
import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/utils/App_SnackBar.dart';
import 'package:http/http.dart';

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
  // Calling Initial State.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRouteArguments();
      _showAppSnackBar();
      _getCountries();
    });
  }

  //  State Variables.
  String _id = '';
  String _message = '';
  String _token = '';
  String _address = '';
  String _city = '';
  String _state = '';
  String _country = '';
  List<String> _cities = [];
  List<String> _states = [];
  List<String> _countries = [];
  String _messageType = 'Success';
  bool _isLoading = false;

  // Class Instances.
  AppSnackBar _appSnackBar = AppSnackBar();
  NetworkHandler _networkHandler = NetworkHandler();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  //  Global Keys.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //  Form Key.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff19769F),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Hepaloop',
          style: TextStyle(
            color: Color(0xff19769F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 84,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                margin: EdgeInsets.only(top: 10.0),
                child: Card(
                  elevation: 5.0,
                  shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Address Details',
                        style: TextStyle(
                          color: Color(0xff19769F),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
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
              ),

              Padding(padding: EdgeInsets.all(9.0)),

              Container(
                // height: MediaQuery.of(context).size.height - 315,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: Card(
                  elevation: 5.0,
                  shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    // height: MediaQuery.of(context).size.height - 320.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 15.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView(
                              shrinkWrap: true,
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
                                    hintText: 'Address',
                                  ),
                                ),

                                Padding(padding: EdgeInsets.all(9.0)),

                                //  Country
                                DropdownButtonFormField<String>(
                                  onChanged: (value) {
                                    setState(() {
                                      _country = value;
                                    });

                                    _getStates(_country);
                                  },
                                  validator: (value) => (value == null)
                                      ? ('Please select your country.')
                                      : (null),
                                  items: _countries.map((eachCountry) {
                                    return DropdownMenuItem(
                                      child: Text(eachCountry),
                                      value: eachCountry,
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    hintText: 'Country',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        12.0, 0.0, 3.0, 0.0),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.all(9.0)),

                                //  State
                                DropdownButtonFormField<String>(
                                  onChanged: (value) {
                                    setState(() {
                                      _state = value;
                                    });

                                    _getCities(_state);
                                  },
                                  validator: (value) => (value == null)
                                      ? ('State is required.')
                                      : (null),
                                  items: _states.map((eachState) {
                                    return DropdownMenuItem(
                                      child: Text(eachState),
                                      value: eachState,
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    hintText: 'State',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        12.0, 0.0, 3.0, 0.0),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.all(9.0)),

                                //  City
                                DropdownButtonFormField<String>(
                                  onChanged: (value) {
                                    setState(() {
                                      _city = value;
                                    });
                                  },
                                  validator: (value) => (value == null)
                                      ? ('City is required.')
                                      : (null),
                                  items: _cities.map((eachCity) {
                                    return DropdownMenuItem(
                                      child: Text(eachCity),
                                      value: eachCity,
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    hintText: 'City',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        12.0, 0.0, 3.0, 0.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ),

              Expanded(
                child: Container(),
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
      ),
    );
  }

  _getRouteArguments() {
    setState(() {
      _id = widget.routeArguments['id'];
      _message = widget.routeArguments['message'];
      _token = widget.routeArguments['token'];
    });
  }

  //  Show a success Toast.
  void _showAppSnackBar() {
    _scaffoldKey.currentState.showSnackBar(
      _appSnackBar.snackBar(_message, _messageType),
    );
  }

  Future _submitDoctorsAddress() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        // _isLoading = true;
      });

      // Request Payload.
      Map<String, dynamic> body = {
        'doctors_address': _address,
        'doctors_city': _city,
        'doctors_state': _state,
        'doctors_country': _country,
      };
      print(body);

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

        _showBottomSheet();
      } else {
        setState(() {
          _isLoading = false;
          _messageType = 'Error';
        });

        //  Show SnackBar.
        _scaffoldKey.currentState.showSnackBar(_appSnackBar.snackBar(
            'Yeah...   Response gone Wrong...', _messageType));
      }
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

  //  Get Countries.
  void _getCountries() async {
    //  Firstly make a Network Call to fetch all the Countries of the world.
    Response countryResponse =
        await _networkHandler.getWorldCountries(getCountriesRoute);

    var countryResponseBody = jsonDecode(countryResponse.body);

    /**
     * Map through each "countryResponseBody" items and extract the "country_name"
     * and add it to the List of "countryNameList".
     * */
    if (countryResponse.statusCode == 200) {
      List<String> _countryNameList = [];
      countryResponseBody.forEach((eachCountry) {
        return _countryNameList.add(eachCountry['country_name']);
      });

      setState(() {
        _countries = _countryNameList;
      });
    } else {
      //  Show SnackBar.
      _scaffoldKey.currentState.showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch countries...', 'Error'),
      );
    }

    // print(countryResponseBody);
    // print(_countries);
  }

  //  Get States.
  void _getStates(String selectedCountry) async {
    Response stateResponse =
        await _networkHandler.getStates(getStatesRoute, selectedCountry);

    var stateResponseBody = jsonDecode(stateResponse.body);

    if (stateResponse.statusCode == 200) {
      List<String> _stateNameList = [];

      stateResponseBody.forEach((eachState) {
        return _stateNameList.add(eachState['state_name']);
      });

      setState(() {
        _states = _stateNameList;
      });
    } else {
      //  Show SnackBar.
      _scaffoldKey.currentState.showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch states...', 'Error'),
      );
    }

    // print(stateResponse.statusCode);
    // print(stateResponseBody);
  }

  //  Get Cities.
  void _getCities(String selectedState) async {
    Response cityResponse =
        await _networkHandler.getCities(getCitiesRoute, selectedState);

    var cityResponseBody = jsonDecode(cityResponse.body);

    if (cityResponse.statusCode == 200) {
      List<String> _cityNameList = [];

      cityResponseBody.forEach((eachState) {
        return _cityNameList.add(eachState['city_name']);
      });

      setState(() {
        _cities = _cityNameList;
      });
    } else {
      //  Show SnackBar.
      _scaffoldKey.currentState.showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch cities...', 'Error'),
      );
    }

    // print(cityResponse.statusCode);
    // print(cityResponseBody);
  }

  Future _showBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((builder) {
        return Container(
          height: 400.0,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  Animated Image.
                    Image.asset(
                      'images/animated_check_mark.gif',
                      height: 100.0,
                      width: 100.0,
                    ),

                    Padding(padding: EdgeInsets.all(9.0)),

                    // Congratulations.
                    Text(
                      'Congratulations!!!',
                      style: TextStyle(
                        color: Color(0xff19769F),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(5.0)),

                    Text(
                      'You\'ve successfully completed your registration. Please kindly login to the access Hepaloop.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, loginScreen);
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
                      'Ok',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
