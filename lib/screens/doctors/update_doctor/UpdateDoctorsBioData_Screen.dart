import 'dart:convert';
import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hepaloop/http/Network_Handlers.dart';
import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/utils/App_SnackBar.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDoctorsBioDataScreen extends StatefulWidget {
  final Map<String, dynamic> routeArguments;

  const UpdateDoctorsBioDataScreen({Key key, this.routeArguments})
      : super(key: key);

  @override
  _UpdateDoctorsBioDataScreenState createState() =>
      _UpdateDoctorsBioDataScreenState();
}

class _UpdateDoctorsBioDataScreenState
    extends State<UpdateDoctorsBioDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  Do something only the first time you display a page
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRouteArguments();
      _showAppSnackBar();
    });
  }

  //  State Variables.
  String _id = '';
  String _message = '';
  String _token = '';
  String _doctorsAvatar = '';
  String _doctorsSpecialty = '';
  String _doctorsHospital = '';
  String _imageFile = '';
  String _messageType = 'Success';
  bool _isLoading = false;

  // Class Instances.
  AppSnackBar _appSnackBar = AppSnackBar();
  NetworkHandler _networkHandler = NetworkHandler();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  ImagePicker _imagePicker = ImagePicker();
  PickedFile _pickedFile;

  //  Global Keys.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //  Form Key.

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
                Navigator.pushNamed(context, updateDoctorAddressScreen);
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
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar(
          'Tap back again to exit the app.',
          'Info',
        ),
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
                  height: 280,
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
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 5.0),
                            child: Form(
                                key: _formKey,
                                autovalidateMode: _autoValidateMode,
                                child: ListView(
                                  children: [
                                    Padding(padding: EdgeInsets.all(15.0)),

                                    //  Doctors Specialty
                                    DropdownButtonFormField<String>(
                                      onChanged: (value) {
                                        setState(() {
                                          _doctorsSpecialty = value;
                                        });
                                      },
                                      validator: (value) => (value == null)
                                          ? ('Please select a user type.')
                                          : (null),
                                      items:
                                          _doctorsSpecialtyList.map((eachItem) {
                                        return DropdownMenuItem(
                                          value: eachItem,
                                          child: Text(eachItem),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        hintText: 'Specialty',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 15.0,
                                        ),
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(9.0)),

                                    //  Doctors Place of Work
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _doctorsHospital = value;
                                        });
                                      },
                                      validator: RequiredValidator(
                                          errorText: 'Country is required.'),
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
                                        hintText: 'Hospital (Place of work)',
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
                                        _showBottomSheet();
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
                        _submitDoctorsBioData();
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

  Future _submitDoctorsBioData() async {
    //  Validate the Input Fields.
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      //  Get the Map of the Update Request Body.
      Map<String, dynamic> body = {
        'doctors_specialty': _doctorsSpecialty,
        'doctors_hospital': _doctorsHospital,
      };

      Response response = await _networkHandler.updateDoctor(
          updateDoctorRoute, _id, body, _token);

      //  Decode the "response.dody" to get the body of the response.
      var responseBody = jsonDecode(response.body);

      var isSuccess = responseBody['success'];
      if (isSuccess) {
        if (_pickedFile != null) {
          StreamedResponse response = await _networkHandler.updateUsersAvatar(
            updateDoctorAvatarRoute,
            _pickedFile.path,
            _token,
          );

          //  Decode the "response.dody" to get the body of the response.
          var responseBody = await response.stream.bytesToString();
          var decodedResponse = jsonDecode(responseBody);
          var doctorData = decodedResponse['data']['doctor'];
          var isAvatarUploadSuccess = decodedResponse['success'];

          if (isAvatarUploadSuccess) {
            setState(() {
              _isLoading = false;
            });

            Map<String, dynamic> _argumentPayload = {
              "id": doctorData['id'],
              'message': decodedResponse['message'],
              'token': _token,
            };

            Navigator.pushNamed(
              context,
              updateDoctorAddressScreen,
              arguments: _argumentPayload,
            );
          } else {
            setState(() {
              _isLoading = false;
              _messageType = 'Error';
            });
            _scaffoldKey.currentState.showSnackBar(
              _appSnackBar.snackBar(decodedResponse['message'], _messageType),
            );
          }
        } else {
          setState(() {
            _isLoading = false;
            _messageType = 'Error';
          });
          _scaffoldKey.currentState.showSnackBar(
            _appSnackBar.snackBar('No image selected.', _messageType),
          );
        }
      }
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
        _isLoading = false;
      });
    }
  }

  Future _showBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((builder) {
        return Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Choose photo from:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff19769F),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    _takePicture(ImageSource.camera);
                    Navigator.of(context)
                        .pop(); //  To Automatically Close the BottomSheet.
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera, color: Colors.black45),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text('Camera',
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.black45,
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    _takePicture(ImageSource.gallery);
                    Navigator.of(context)
                        .pop(); //  To Automatically Close the BottomSheet.
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image_rounded, color: Colors.black45),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text('Gallery',
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.black45,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future _takePicture(ImageSource imageSource) async {
    try {
      final _selectedImage = await _imagePicker.getImage(
        source: imageSource,
        maxHeight: 600.0,
        maxWidth: 600.0,
        imageQuality: 80,
      );
      setState(() {
        if (_selectedImage != null) {
          return _pickedFile = _selectedImage;
        }
        return _scaffoldKey.currentState.showSnackBar(
          _appSnackBar.snackBar('No image selected.', 'Error'),
        );
      });
    } catch (error) {
      print(error);
    }
  }
}
