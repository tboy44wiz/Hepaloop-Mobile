import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_snackBar_widget.dart';
import '../models/doctor_model.dart';
import '../models/individual_model.dart';
import '../widgets/show_signup_completed_bottom_sheet_widget.dart';

class AuthStateController extends GetxController {

  String _firstName = "";
  String _lastName = "";
  String _fullName = "";
  String _email = "";
  String _phone = "";
  String _password = "";
  String _confirmPassword = "";
  String _role = "";

  // User Address
  String _address = '';
  String _city = '';
  String _state = '';
  String _country = '';
  final List<String> _cities = [];
  final List<String> _states = [];
  final List<String> _countries = [];

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _showFirstAndLastNameTextFormField = true;
  bool _showFullNameTextFormField = false;
  bool _isLoading = false;
  File? _pickedFile;
  final ImagePicker _imagePicker = ImagePicker();
  Map<String, dynamic> _userDetail = {};

  Doctor _doctor = Doctor();
  Individual _individual = Individual();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final AppSnackBar _appSnackBar = AppSnackBar();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();


  /*
  * GETTERS
  * */
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get fullName => _fullName;
  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get role => _role;

  // User Address
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get country => _country;
  List<String> get cities => _cities;
  List<String> get states => _states;
  List<String> get countries => _countries;

  bool get hidePassword => _hidePassword;
  bool get hideConfirmPassword => _hideConfirmPassword;
  bool get showFirstAndLastNameTextFormField => _showFirstAndLastNameTextFormField;
  bool get showFullNameTextFormField => _showFullNameTextFormField;
  bool get isLoading => _isLoading;
  File? get pickedFile => _pickedFile;
  Map<String, dynamic> get userDetail => _userDetail;

  Doctor get doctor => _doctor;
  Individual get individual => _individual;

  AutovalidateMode get autoValidateMode => _autoValidateMode;
  FlutterSecureStorage get flutterSecureStorage => _flutterSecureStorage;

  /*
  * SETTERS
  * */
  void updateFirstName(String value) {
    _firstName = value;
    update();
  }
  void updateLastName(String value) {
    _lastName = value;
    update();
  }
  void updateFullName(String value) {
    _fullName = value;
    update();
  }
  void updateEmail(String value) {
    _email = value;
    update();
  }
  void updatePhoneNumber(String value) {
    _phone = value;
    update();
  }
  void updatePassword(String value) {
    _password = value;
    update();
  }
  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    update();
  }
  void updateHidePassword() {
    _hidePassword = !_hidePassword;
    update();
  }
  void updateHideConfirmPassword() {
    _hideConfirmPassword = !_hideConfirmPassword;
    update();
  }
  void updateRole(String value) {
    List<String> formattedValue = value.split(" ");
    _role = formattedValue[1];

    if (value == "A Doctor" || value == "An Individual") {
      _showFirstAndLastNameTextFormField = true;
      _showFullNameTextFormField = false;
    } else {
      _showFirstAndLastNameTextFormField = false;
      _showFullNameTextFormField = true;
    }
    update();
  }
  void updateAutoValidateMode() {
    _autoValidateMode = AutovalidateMode.onUserInteraction;
    update();
  }
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }
  void updateAddress(String value) {
    _address = value;
    update();
  }
  void updateCity(String value) {
    _city = value;
    update();
  }
  void updateState(String value) {
    _state = value;
    update();
  }
  void updateCountry(String value) {
    _country = value;
    update();
  }
  void updateUserDetail(Map<String, dynamic> value) {
    _userDetail = value;
    update();
  }
  void updateDoctor(Doctor doctorValue) {
    _doctor = doctorValue;
    update();
  }
  void updateIndividual(Individual individualValue) {
    _individual = individualValue;
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

    });
    super.onInit();
  }

  // Get Countries.
  void getCountries() async {
    updateIsLoading(true);

    var countryResponse = await APIService.getWorldCountries(getCountriesRoute);

    /**
     * Map through each "countryResponseBody" items and extract the "country_name"
     * and add it to the List of "countryNameList".
     * */
    if (countryResponse!.statusCode == 200) {
      var countryResponseData = countryResponse.data;
      countryResponseData.forEach((eachCountry) {
        _countries.add(eachCountry['country_name']);
        updateIsLoading(false);
        update();
      });
    } else {
      updateIsLoading(false);
      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch countries...', 'Error'),
      );
    }
  }

  //  Get States.
  void getStates(String selectedCountry) async {
    updateIsLoading(true);

    var stateResponse = await APIService.getStates(getStatesRoute, selectedCountry);

    if (stateResponse!.statusCode == 200) {
      var stateResponseBody = stateResponse.data;

      stateResponseBody.forEach((eachState) {
        _states.add(eachState['state_name']);
        updateIsLoading(false);
        update();
      });
    } else {
      updateIsLoading(false);
      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch states...', 'Error'),
      );
    }
  }

  //  Get Cities.
  void getCities(String selectedState) async {
    updateIsLoading(true);

    var cityResponse = await APIService.getCities(getCitiesRoute, selectedState);

    if (cityResponse!.statusCode == 200) {
      var cityResponseBody = cityResponse.data;

      cityResponseBody.forEach((eachState) {
        _cities.add(eachState['city_name']);
        updateIsLoading(false);
        update();
      });
    } else {
      updateIsLoading(false);
      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Oops!!! Couldn\'t fetch cities...', 'Error'),
      );
    }
  }


  //  Take a picture.
  Future<void> takePicture(ImageSource imageSource) async {
    try {
      final image = await _imagePicker.pickImage(
        source: imageSource,
        maxHeight: 600.0,
        maxWidth: 600.0,
        imageQuality: 80,
      );
      if (image != null) {
        // Note: The "image" is type "XFile" and need to be made type "File" as did below.
        _pickedFile = File(image.path);
        return update();
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('No image selected.', 'Error'),
      );
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }


  //  Login User.
  Future<void> loginUser() async {
    updateIsLoading(true);

    Map<String, dynamic> loginData = {
      "email": _email,
      "password": _password
    };
    var response = await APIService.loginUserService(loginUserRoute, loginData);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);
      Map<String, dynamic> userData = response.data["data"];

      String _encodedDoctorData = jsonEncode(userData);
      await _flutterSecureStorage.write(key: 'loggedInUser', value: _encodedDoctorData);

      (userData["role"] == "Doctor") ? ({
        updateDoctor(Doctor.fromMap(userData)),
        Get.offNamed(doctorsMainScreen)
      }) : (userData["role"] == "Individual") ? ({
        updateIndividual(Individual.fromMap(userData)),
        Get.offNamed(individualsMainScreen)
      }) : (userData["role"] == "Hospital") ? ({
        Get.toNamed(hospitalDashBoardScreen)
      }) : ({
        Get.toNamed(pharmacyDashBoardScreen)
      });
    } else {
      updateIsLoading(false);

      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          _appSnackBar.snackBar("Ooops!!! ${response.data['message']}", "Error")
      );
    }
  }

  //  Signup User.
  Future<void> signupUser() async {
    updateIsLoading(true);

    Map<String, dynamic> signupData = {
      "name": "$_firstName $_lastName",
      "email": _email,
      "phone": _phone,
      "password": _password,
      "confirmPassword": _confirmPassword,
      "address": _address,
      "city": _city,
      "state": _state,
      "country": _country,
      "role": _role
    };
    /*Map<String, dynamic> signupData = {
      "name": 'Becky Lee',
      "email": 'becky@yahoo.com',
      "phone": '09066443589',
      "password": 'password123',
      "confirmPassword": 'password123',
      "address": '12 James Robertson Street Surulere Lagos',
      "city": 'Surulere',
      "state": 'Lagos',
      "country": 'Nigeria',
      "role": 'Individual'
    };*/

    //  Then call the method that makes the network call.
    var response = await APIService.signupUserService(signUpUserRoute, signupData);

    bool isSuccess = response!.data["success"];
    if (isSuccess) {
      updateIsLoading(false);
      Map<String, dynamic> userData = response.data["data"];
      updateUserDetail(userData);

      (userData["role"] == "Doctor") ? (
          Get.toNamed(updateDoctorDataAuthScreen)
      ) : (userData["role"] == "Individual") ? (
          Get.offNamed(updateIndividualDataAuthScreen)
      ) : (userData["role"] == "Hospital") ? (
          Get.toNamed(signUpStepThreeScreen)
      ) : (
          Get.toNamed(signUpStepThreeScreen)
      );
    } else {
      updateIsLoading(false);

      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          _appSnackBar.snackBar("Ooops!!! ${response.data['message']}", "Error")
      );
    }
  }


  //  Upload the Users Profile.
  Future<void> uploadUserPicture() async {
    updateIsLoading(true);

    var response = await APIService.updateUserPicture(updateUserPictureRoute, _pickedFile!.path, _userDetail["token"]);

    bool isSuccess = response!.data["success"];
    if (isSuccess) {
      updateIsLoading(false);

      Map<String, dynamic> userData = response.data["data"];
      String userRole = userData["role"];

      String _encodedDoctorData = jsonEncode(userData);
      await _flutterSecureStorage.write(key: 'loggedInUser', value: _encodedDoctorData);

      //  Save to users corresponding models.
      (userRole == "Doctor") ? (
          updateDoctor(Doctor.fromMap(userData))
      ) : (userRole == "Individual") ? (
          updateIndividual(Individual.fromMap(userData))
      ) : (userRole == "Hospital") ? (
          updateDoctor(Doctor.fromMap(userData))
      ) : (
          updateDoctor(Doctor.fromMap(userData))
      );

      ShowSignUpCompletedBottomSheetWidget.showSignUpCompletedBottomSheet(userRole);
    } else {
      updateIsLoading(false);

      //  Show SnackBar.
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar(response.data["message"], "Error")
      );
    }
  }
}