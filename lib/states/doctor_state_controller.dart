import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hepaloop/models/doctor_model.dart';
import 'package:intl/intl.dart';

import '../models/individual_model.dart';
import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_snackBar_widget.dart';
import '../states/auth_state_controller.dart';

class DoctorStateController extends GetxController {

  String _gender = '';
  String _specialty = '';
  String _hospital = '';
  String _startingYearOfPractice = '';
  String _bioInfo = '';
  bool _isLoading = false;
  String _viewType = "GridView";
  int _selectedBottomNavigationBarIndex = 0;
  final List<String> _specialtyList = [
    'Surgeon',
    'Cardiologist',
    'Obstetrician',
    'Oncologist',
    'Ophthalmologist',
    'Pediatrician',
    'Pathologist',
    'Radiologist',
    'Psychiatrist',
    'General Practitioner',
  ];
  List<Individual> _doctorsPatientList = [];

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _startingYearOfPracticeEditingController = TextEditingController();
  final AuthStateController _authStateController = Get.put(AuthStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  //  Models
  Individual _individual = Individual();
  Doctor _doctor = Doctor();

  //
  /*
  * GETTERS
  * */
  String get gender => _gender;
  String get specialty => _specialty;
  String get hospital => _hospital;
  List<String> get specialtyList => _specialtyList;
  String get startingYearOfPractice => _startingYearOfPractice;
  String get bioInfo => _bioInfo;
  bool get isLoading => _isLoading;
  String get viewType => _viewType;
  int get selectedBottomNavigationBarIndex => _selectedBottomNavigationBarIndex;
  List<Individual> get doctorsPatientList => _doctorsPatientList;

  AutovalidateMode get autoValidateMode => _autoValidateMode;
  TextEditingController get startingYearOfPracticeEditingController => _startingYearOfPracticeEditingController;
  FlutterSecureStorage get flutterSecureStorage => _flutterSecureStorage;

  //  Models
  Individual get individual => _individual;
  Doctor get doctor => _doctor;


  //
  /*
  * SETTERS
  * */
  void updateGender(String value) {
    _gender = value;
    update();
  }
  void updateSpecialty(String value) {
    _specialty = value;
    update();
  }
  void updateHospital(String value) {
    _hospital = value;
    update();
  }
  void updateBioInfo(String value) {
    _bioInfo = value;
    update();
  }
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }
  void updateViewType(String value) {
    _viewType = value;
    update();
  }
  void updateSelectedBottomNavigationBarIndex(int index) {
    _selectedBottomNavigationBarIndex = index;
    update();
  }
  void updateAutoValidateMode() {
    _autoValidateMode = AutovalidateMode.onUserInteraction;
    update();
  }
  void updateDoctorsPatientList(List<Individual> doctorsPatient) {
    _doctorsPatientList = doctorsPatient;
    update();
  }


  //  Read the Doctor Details saved in the FlutterSecureStorage
  void getDoctorsDetails() async {
    var _usersData = await _flutterSecureStorage.read(key: 'loggedInUser');
    if (_usersData != null) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);
      _doctor = Doctor.fromMap(_decodedUSerData);
      update();
    }
  }

  //  Update Show Default DatePicker.
  void showDefaultDatePicker() async {
    var _selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: (_startingYearOfPractice != "")
          ? (DateTime.parse(_startingYearOfPractice))
          : (DateTime.now()),
      firstDate: DateTime(1920, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Select your started year of practice',
    );

    //  Saving the Date.
    if (_selectedDate != null) {
      //  Format the _selectedDate.
      DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
      String _formattedDate = _dateFormatter.format(_selectedDate);

      _startingYearOfPractice = _formattedDate;

      _startingYearOfPracticeEditingController.text = DateFormat('yyyy').format(_selectedDate);
      update();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Please select a date.', 'Info'),
      );
    }
  }

  //  Create a Doctor
  Future<void> createDoctor() async {
    updateIsLoading(true);

    Map<String, dynamic> doctorData = {
      "gender": _gender,
      "specialty": _specialty,
      "hospital": _hospital,
      "syop": _startingYearOfPractice,
      "bioInfo": _bioInfo,
      "rating": "1",
    };

    //  Then call the method that makes the network call.
    var response = await APIService.createDoctorService(createDoctorRoute, doctorData, _authStateController.userDetail["token"]);

    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      //  Then upload the Users Profile.
      _authStateController.uploadUserPicture();
      return;
    }
  }

  //  Get All Doctor's Patients.
  Future<void> getDoctorPatient() async {
    updateIsLoading(true);

    var response = await APIService.getDoctorPatientService(getAllDoctorPatientsRoute, doctor.token!);

    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      List<dynamic> doctorsPatientData = response.data["data"];
      List<Individual> doctorsPatient = List<Individual>.from(doctorsPatientData.map((eachIndividual) => Individual.fromMap(eachIndividual)));

      updateDoctorsPatientList(doctorsPatient);
      print("RESPONSE::: $doctorsPatientData");
    }
  }


  //  Extract Selected Patient
  extractSelectedPatientsData(String patientId) {
    //Extract the First matching Patient.
    _individual = _doctorsPatientList.firstWhere((eachElement) => eachElement.id == patientId);
    update();
  }


  //  Logout Doctor.
  void logoutDoctor() async {
    await _flutterSecureStorage.delete(key: 'loggedInUser');

    //  Return to the Login Screen.
    Get.offNamed(loginScreen);
  }

}