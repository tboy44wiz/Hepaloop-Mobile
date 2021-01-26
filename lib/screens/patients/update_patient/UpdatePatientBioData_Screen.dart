import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/utils/App_SnackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdatePatientBioDataScreen extends StatefulWidget {
  final Map<String, dynamic> routeArguments;

  const UpdatePatientBioDataScreen({Key key, this.routeArguments})
      : super(key: key);

  @override
  _UpdatePatientBioDataScreenState createState() =>
      _UpdatePatientBioDataScreenState();
}

class _UpdatePatientBioDataScreenState
    extends State<UpdatePatientBioDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRouteArguments();
      _showAppSnackBar();
    });
  }

  //  State Variables.
  String _id = '';
  String _message = '';
  String _token = '';
  String _imageFile = '';
  String _patientsGender = '';
  String _patientsAvatar = '';
  String _patientsHeight = '';
  String _patientsWeight = '';
  String _patientsDOB = '';
  String _messageType = 'Success';
  bool _isLoading = false;

  var _doctorsSpecialtyList = [
    'Surgeon',
    'Cardiologists',
    'Obstetrician',
    'Oncologist',
    'Ophthalmologist',
    'Pediatricians',
    'Pathologists',
    'Radiologists',
    'Psychiatrists',
    'General Practitioner',
  ];

  // Class Instances.
  AppSnackBar _appSnackBar = AppSnackBar();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  ImagePicker _imagePicker = ImagePicker();
  PickedFile _pickedFile;

  //  Global Keys.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //  Form Key.

  //  TextEdi
  TextEditingController _patientsDOBEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Hepaloop',
          style: TextStyle(
            color: Color(0xff19769F),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, updatePatientAddressScreen);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
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
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
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
                          'Bio Data',
                          style: TextStyle(
                            color: Color(0xff19769F),
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Please tell us about yourself.',
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
                  height: 400,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height / 1.4) - 50,
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints.expand(),
                        margin: EdgeInsets.only(top: 50.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 25.0),
                        child: Card(
                          elevation: 5.0,
                          shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 5.0),
                            child: Form(
                                key: _formKey,
                                autovalidateMode: _autoValidateMode,
                                child: ListView(
                                  children: [
                                    Padding(padding: EdgeInsets.all(15.0)),

                                    //  Patients Gender.
                                    DropdownButtonFormField<String>(
                                      onChanged: (value) {
                                        setState(() {
                                          _patientsGender = value;
                                        });
                                        print(_patientsGender);
                                      },
                                      validator: (value) => (value == null)
                                          ? ('Please select yur gender.')
                                          : (null),
                                      items:
                                          ['Male', 'Female'].map((eachGender) {
                                        return DropdownMenuItem(
                                          child: Text(eachGender),
                                          value: eachGender,
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        hintText: 'Gender',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 15.0,
                                        ),
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(9.0)),

                                    //  Patients Height
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _patientsHeight = value;
                                        });
                                        print(_patientsHeight);
                                      },
                                      validator: RequiredValidator(
                                          errorText: 'Height is required.'),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        hintText: 'Height in (Meters)',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 15.0,
                                        ),
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(9.0)),

                                    //  Patients Weight
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _patientsWeight = value;
                                        });
                                        print(_patientsWeight);
                                      },
                                      validator: RequiredValidator(
                                          errorText: 'Weight is required.'),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 15.0,
                                        ),
                                        hintText: 'Weight in (Kilogram)',
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(9.0)),

                                    //  Patients Date Of Birth
                                    TextFormField(
                                      onTap: () {
                                        // Below line stops keyboard from appearing
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());

                                        // Show Date Picker Here
                                        // _showDatePicker();
                                        _showDefaultDatePicker();
                                        print(_patientsDOB);
                                      },
                                      controller: _patientsDOBEditingController,
                                      validator: RequiredValidator(
                                          errorText:
                                              'Date if birth is required.'),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 15.0,
                                        ),
                                        hintText: 'Date of birth',
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),

                      //  Doctors Profile Picture
                      Positioned(
                        top: 6.0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 45.0,
                                    backgroundImage: (_pickedFile == null)
                                        ? AssetImage(
                                            'images/profile_avatar.png')
                                        : FileImage(File(_pickedFile.path)),
                                  ),
                                ),
                                Positioned(
                                  height: 30.0,
                                  width: 30.0,
                                  top: 65.0,
                                  // left: 0,
                                  right: 3.0,
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xff19769F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // _showBottomSheet();
                                        // _showCustomDialog();
                                      },
                                      color: Color(0xff19769F),
                                      padding: EdgeInsets.all(8.0),
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                //  Submit Button.
                Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        _submitPatientsBioData();
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
                                'Submit',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getRouteArguments() {
    setState(() {
      _id = widget.routeArguments['id'];
      _message = widget.routeArguments['message'];
      _token = widget.routeArguments['token'];
    });
  }

  void _showAppSnackBar() {
    _scaffoldKey.currentState.showSnackBar(
      _appSnackBar.snackBar(_message, _messageType),
    );
  }

  void _showDatePicker() async {
    await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1920, 1, 1),
        maxTime: DateTime.now().add(Duration(days: 365)),
        locale: LocaleType.en,
        currentTime: DateTime.parse(_patientsDOB), onChanged: (date) {
      setState(() {
        _patientsDOB = date.toString();
      });
    }, onConfirm: (date) {
      DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
      String _formattedDate = _dateFormatter.format(date);
      setState(() {
        _patientsDOB = _formattedDate;
      });
      print('CONFIRM::: $_formattedDate');
    }, onCancel: () {
      _scaffoldKey.currentState.showSnackBar(
        _appSnackBar.snackBar('Please be sure of your selection.', 'Info'),
      );
    });
  }

  void _showDefaultDatePicker() async {
    var _selectedDate = await showDatePicker(
      context: context,
      initialDate: (_patientsDOB != "")
          ? (DateTime.parse(_patientsDOB))
          : (DateTime.now()),
      firstDate: DateTime(1920, 1, 1),
      lastDate: DateTime.now().add(Duration(days: 365)),
      helpText: 'Select your date of birth',
    );

    //  Saving the Date.
    if (_selectedDate != null) {
      //  Format the _selectedDate.
      DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
      String _formattedDate = _dateFormatter.format(
        _selectedDate,
      );

      setState(() {
        _patientsDOB = _formattedDate;
      });

      _patientsDOBEditingController.text =
          DateFormat('dd-MM-yyyy').format(_selectedDate);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        _appSnackBar.snackBar('Please select a date.', 'Info'),
      );
    }
  }

  Future _submitPatientsBioData() async {
    //  First, Compute the patients age from the DOB.
    DateTime today = DateTime.now();
    DateFormat _dateFormatter = DateFormat('yyyy');
    var _currentYear = _dateFormatter.format(today);
    var _yearOfBirth = _dateFormatter.format(DateTime.parse(_patientsDOB));

    //  Subtract the YearOfBirth from the CurrentYear.
    var _age = int.parse(_currentYear) - int.parse(_yearOfBirth);
    print(_age);

    Map<String, dynamic> body = {
      'patients_gender': _patientsGender,
      'patients_height': _patientsHeight,
      'patients_weight': _patientsWeight,
      'patients_age': _age,
    };
  }
}
