import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hepaloop/services/socketIO_service.dart';
import 'package:intl/intl.dart';

import '../models/individual_model.dart';
import '../models/doctor_model.dart';
import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_snackBar_widget.dart';
import '../states/auth_state_controller.dart';

class IndividualStateController extends GetxController {

  String _gender = '';
  String _dateOfBirth = '';
  int _age = 0;
  String _height = '';
  String _weight = '';
  bool _isLoading = false;
  int _selectedBottomAppBarIndex = 0;
  int _selectedBottomNavigationBarIndex = 0;

  //  My Doctors List Screen
  String _viewType = "GridView";
  int? _selectedSpecialistIndex;
  static List<dynamic> _nearbyDoctors = [];
  List<dynamic> _nearbySpecialist = [];
  List<Map<String, dynamic>> _doctorsSpecialtyList = [];
  String? _yearsOfExperience;
  List<Doctor> _patientsDoctorList = [];

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final TextEditingController _dateOfBirthEditingController = TextEditingController();
  final AuthStateController _authStateController = Get.put(AuthStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();

  //  Models
  Individual _individual = Individual();
  Doctor _doctor = Doctor();

  //
  /*
  * GETTERS
  * */
  String get gender => _gender;
  String get dateOfBirth => _dateOfBirth;
  int get age => _age;
  String get height => _height;
  String get weight => _weight;
  bool get isLoading => _isLoading;
  int get selectedBottomAppBarIndex => _selectedBottomAppBarIndex;
  int get selectedBottomNavigationBarIndex => _selectedBottomNavigationBarIndex;

  //  My Doctors List Screen
  String get viewType => _viewType;
  int? get selectedSpecialistIndex => _selectedSpecialistIndex;
  List<dynamic> get nearbyDoctors => _nearbyDoctors;
  List<dynamic> get nearbySpecialist => _nearbySpecialist;
  List<Map<String, dynamic>> get doctorsSpecialtyList => _doctorsSpecialtyList;
  String? get yearsOfExperience => _yearsOfExperience;
  List<Doctor> get patientsDoctorList => _patientsDoctorList;

  AutovalidateMode get autoValidateMode => _autoValidateMode;
  TextEditingController get dateOfBirthEditingController => _dateOfBirthEditingController;

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
  void updateDateOfBirth(String value) {
    _dateOfBirth = value;
    update();
  }
  void updateAge(int value) {
    _age = value;
    update();
  }
  void updateHeight(String value) {
    _height = value;
    update();
  }
  void updateWeight(String value) {
    _weight = value;
    update();
  }
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }
  void onBottomAppBarItemTapped(int index) {
    _selectedBottomAppBarIndex = index;
    update();
  }
  void updateSelectedBottomNavigationBarIndex(int index) {
    _selectedBottomNavigationBarIndex = index;
    update();
  }
  updateSelectedSpecialistIndex(int index) {
    _selectedSpecialistIndex = index;
    update();
  }
  void updatePatientsDoctorList(List<Doctor> patientsDoctor) {
    _patientsDoctorList = patientsDoctor;
    update();
  }

  //  My Doctors List Screen
  void updateViewType(String value) {
    _viewType = value;
    update();
  }
  void updateAutoValidateMode() {
    _autoValidateMode = AutovalidateMode.onUserInteraction;
    update();
  }


  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getIndividualDetails();

      if(_individual.token != null) {
        getPatientDoctor();
      }
    });
  }


  /*
  Read the Individual Details saved in the FlutterSecureStorage
  FlutterSecureStorage is Just like we do save things in Shared Preference.
  */
  Future<void> getIndividualDetails() async {
    var _usersData = await _flutterSecureStorage.read(key: 'loggedInUser');
    if (_usersData != null) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);
      _individual = Individual.fromMap(_decodedUSerData);
      update();
    }
  }


  //  Update Show Default DatePicker.
  Future<void> showDefaultDatePicker() async {
    DateTime? _selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: (_dateOfBirth != "")
          ? (DateTime.parse(_dateOfBirth))
          : (DateTime.now()),
      firstDate: DateTime(1920, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Select your year of birth',
    );

    //  Saving the Date.
    if (_selectedDate != null) {
      //  Format the _selectedDate.
      DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
      String _formattedDate = _dateFormatter.format(_selectedDate);

      _dateOfBirth = _formattedDate;

      _dateOfBirthEditingController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      update();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Please select a date.', 'Info'),
      );
    }
  }
  /*Future<void> showTimeOfDayPicker() async {
    TimeOfDay? _selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      helpText: 'Select your preferred time.',
    );

    if (_selectedTime != null) {
      String formattedTime = _selectedTime.format(Get.context!);
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        _appSnackBar.snackBar('Please select a date.', 'Info'),
      );
    }
  }*/

  Future<void> createIndividual() async {
    updateIsLoading(true);

    //  Compute the individuals age from the DOB.
    if (_dateOfBirth != "") {
      DateTime today = DateTime.now();
      DateTime dob = DateTime.parse(_dateOfBirth);
      Duration ageDifference = today.difference(dob);
      _age = (ageDifference.inDays / 365).floor();
    }

    Map<String, dynamic> individualData = {
      "gender": _gender,
      "dob": _dateOfBirth,
      "age": _age,
      "height": _height,
      "weight": _weight,
    };

    //  Then call the method that makes the network call.
    var response = await APIService.createIndividualService(createIndividualRoute, individualData, _authStateController.userDetail["token"]);

    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      //  Then upload the Users Profile.
      _authStateController.uploadUserPicture();
      return;
    }
  }




  /*
  * My Doctors List Screen
  * */
  //  When a Specialist Item is Clicked.
  handleSpecialistItemClicked(String specialistName) {
    // var listOfSpecialist = _getSpecialistCount(specialistName);
    _nearbySpecialist = _nearbyDoctors.where((eachDoctor) => eachDoctor["specialty"] == specialistName).toList();
    update();
  }

  //  Get the Number of Specialist.
  static List<dynamic> _getSpecialistCount(String specialistName) {
    return _nearbyDoctors.where((eachDoctor) => eachDoctor["specialty"] == specialistName).toList();
  }

  //  Get All Nearby Doctors
  Future<void> getAllNearByDoctors() async {
    updateIsLoading(true);

    var response = await APIService.getAllNearByDoctorsService(
        getAllNearByDoctorsRoute,
        _individual.city!,
        _individual.token!
    );

    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      _nearbyDoctors = response.data["data"];
      _nearbySpecialist = _nearbyDoctors;
      _doctorsSpecialtyList = [
        {
          'name': 'Surgeon',
          'icon': 'images/specialist_icons/surgery.png',
          'number': _getSpecialistCount('Surgeon').length,
        },
        {
          'name': 'Cardiologist',
          'icon': 'images/specialist_icons/cardiology.png',
          'number': _getSpecialistCount('Cardiologist').length,
        },
        {
          'name': 'Obstetrician',
          'icon': 'images/specialist_icons/obstetrician.png',
          'number': _getSpecialistCount('Obstetrician').length,
        },
        {
          'name': 'Oncologist',
          'icon': 'images/specialist_icons/oncologist.png',
          'number': _getSpecialistCount('Oncologist').length,
        },
        {
          'name': 'Ophthalmologist',
          'icon': 'images/specialist_icons/ophthalmology.png',
          'number': _getSpecialistCount('Ophthalmologist').length,
        },
        {
          'name': 'Pediatrician',
          'icon': 'images/specialist_icons/pediatricians.png',
          'number': _getSpecialistCount('Pediatrician').length,
        },
        {
          'name': 'Pathologist',
          'icon': 'images/specialist_icons/pathologists.png',
          'number': _getSpecialistCount('Pathologist').length,
        },
        {
          'name': 'Radiologist',
          'icon': 'images/specialist_icons/radiology.png',
          'number': _getSpecialistCount('Radiologist').length,
        },
        {
          'name': 'Psychiatrist',
          'icon': 'images/specialist_icons/psychiatrists.png',
          'number': _getSpecialistCount('Psychiatrist').length,
        },
        {
          'name': 'Gen Practitioner',
          'icon': 'images/specialist_icons/gen_practitioner.png',
          'number': _getSpecialistCount('Gen Practitioner').length,
        },
      ];
      update();
    }
  }

  //  Extract Selected Doctor
  extractSelectedDoctorsData(String doctorsId) {
    //Extract the First matching Specialist Doctor.
    Map<String, dynamic> _selectedDoctor = _nearbySpecialist.firstWhere((eachElement) => eachElement["id"] == doctorsId);
    _doctor = Doctor.fromMap(_selectedDoctor);

    DateTime _currentDate = DateTime.now();
    String _yearsDifference = (_currentDate.difference(_doctor.syop!).inDays / 365).floor().toString();
    _yearsOfExperience = _yearsDifference;
    update();
  }

  //  Consult a Doctor.
  void createConsultation(SocketIOServiceController socketIOServiceController) async {
    updateIsLoading(true);

    Map<String, dynamic> requestConsultationData = {
      "userId": _doctor.id,
      "senderId": _individual.id,
      "receiverId": _doctor.id
    };

    var response = await APIService.createConsultationService(
        createConsultationRequestRoute,
        requestConsultationData,
        _individual.token!
    );

    print("REQUEST RESPONSE::: $response");
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
          _appSnackBar.snackBar(response.data["message"], "Success")
      );
    }
  }

  //  Get All Patient's Doctors.
  Future<void> getPatientDoctor() async {
    updateIsLoading(true);

    var response = await APIService.getPatientDoctorService(getAllIndividualDoctorsRoute, _individual.token!);

    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      List<dynamic> patientDoctorsData = response.data["data"];
      List<Doctor> patientDoctor = List<Doctor>.from(patientDoctorsData.map((eachDoctor) => Doctor.fromMap(eachDoctor)));

      updatePatientsDoctorList(patientDoctor);
      // print("RESPONSE::: $patientDoctorsData");
    }
  }


  //  Extract Selected Doctor
  extractSelectedMyDoctorsData(String doctorId) {
    //Extract the First matching Doctor.
    _doctor = _patientsDoctorList.firstWhere((eachElement) => eachElement.id == doctorId);
    update();
  }


  //  Logout Doctor.
  void logoutDoctor() async {
    await _flutterSecureStorage.delete(key: 'loggedInUser');

    //  Return to the Login Screen.
    Get.offNamed(loginScreen);
  }
}