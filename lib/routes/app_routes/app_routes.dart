import 'package:get/get.dart';
import 'package:hepaloop/screens/individual/individuals_appointment_booking_screen.dart';
import 'package:hepaloop/screens/individual/individuals_appointment_detail_screen.dart';

//  App Route Names.
import '../../screens/auth/update_individual_data_auth_screen.dart';
import '../../screens/consultation/consultation_details_screen.dart';
import '../../screens/doctor/doctors_appointment_booking_screen.dart';
import '../../screens/doctor/doctors_appointments_screen.dart';
import '../../screens/doctor/doctors_activities_screen.dart';
import '../../screens/doctor/doctors_main_screen.dart';
import '../../screens/doctor/my_patient_detail_screen.dart';
import '../../screens/doctor/my_patient_screen.dart';
import '../../screens/individual/doctors_details_and_request_consultation_screen.dart';
import '../../screens/individual/individuals_appointments_list_screen.dart';
import '../../screens/individual/individuals_main_screen.dart';
import '../../screens/individual/my_doctors_detail_screen.dart';
import '../../screens/individual/my_doctors_screen.dart';
import '../../screens/individual/select_doctor_screen.dart';
import '../../screens/notifications/notification_screen.dart';
import './app_route_names.dart';
import '../../screens/boarding_one_screen.dart';
import '../../screens/boarding_two_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_stepOne_screen.dart';
import '../../screens/auth/signup_stepTwo_screen.dart';
import '../../screens/auth/signup_stepThree_screen.dart';
import '../../screens/auth/update_doctor_data_auth_screen.dart';
import '../../screens/hospital/hospital_dash_board_screen.dart';
import '../../screens/individual/individuals_dashboard_screen.dart';
import '../../screens/pharmacy/pharmacy_dash_board_screen.dart';
import '../../screens/doctor/doctors_appointment_detail_screen.dart';
import '../../screens/individual/individuals_blood_sugar_reading_screen.dart';



List<GetPage<dynamic>> getPages = [
  /*
  * Walk-Through Screens.
  */
  GetPage(name: boardingOneScreen, page: () => const BoardingOneScreen()),
  GetPage(name: boardingTwoScreen, page: () => BoardingTwoScreen()),

  /*
  * Auth Screens.
  */
  GetPage(name: loginScreen, page: () => LoginScreen()),
  GetPage(name: signUpStepOneScreen, page: () => SignUpStepOneScreen()),
  GetPage(name: signUpStepTwoScreen, page: () => SignUpStepTwoScreen()),
  GetPage(name: signUpStepThreeScreen, page: () => SignUpStepThreeScreen()),
  GetPage(name: updateDoctorDataAuthScreen, page: () => UpdateDoctorDataAuthScreen()),
  GetPage(name: updateIndividualDataAuthScreen, page: () => UpdateIndividualDataAuthScreen()),
  GetPage(name: updateIndividualDataAuthScreen, page: () => UpdateIndividualDataAuthScreen()),


  /*
  * Doctors Screens.
  */
  GetPage(name: doctorsMainScreen, page: () => DoctorsMainScreen()),
  GetPage(name: myPatientScreen, page: () => MyPatientScreen()),
  GetPage(name: myPatientDetailScreen, page: () => MyPatientDetailScreen()),
  GetPage(name: doctorsActivitiesScreen, page: () => DoctorsActivitiesScreen()),
  GetPage(name: doctorsAppointmentBookingScreen, page: () => DoctorsAppointmentBookingScreen()),
  GetPage(name: doctorsAppointmentScreen, page: () => DoctorsAppointmentScreen(false)),
  GetPage(name: doctorsAppointmentDetailScreen, page: () => const DoctorsAppointmentDetailScreen()),


  /*
  * Individuals Screens.
  */
  GetPage(name: individualsMainScreen, page: () => IndividualsMainScreen()),
  GetPage(name: selectDoctorScreen, page: () => SelectDoctorScreen()),
  GetPage(name: myDoctorsScreen, page: () => MyDoctorsScreen()),
  GetPage(name: doctorsDetailsAndRequestConsultationScreen, page: () => DoctorsDetailsAndRequestConsultationScreen()),
  GetPage(name: myDoctorsDetailScreen, page: () => MyDoctorsDetailScreen()),
  GetPage(name: individualsAppointmentListScreen, page: () => IndividualsAppointmentListScreen(false)),
  GetPage(name: individualsAppointmentBookingScreen, page: () => IndividualsAppointmentBookingScreen()),
  GetPage(name: individualsAppointmentDetailScreen, page: () => const IndividualsAppointmentDetailScreen()),
  GetPage(name: individualsBloodSugarReadingScreen, page: () => IndividualsBloodSugarReadingScreen()),


  /*
  * Hospital Screens.
  */
  GetPage(name: hospitalDashBoardScreen, page: () => const HospitalDashBoardScreen()),


  /*
  * Pharmacy Screens.
  */
  GetPage(name: pharmacyDashBoardScreen, page: () => const PharmacyDashBoardScreen()),


  /*
  * Notification Screens.
  */
  GetPage(name: notificationScreen, page: () => NotificationScreen()),



  /*
  * Consultation Screens.
  */
  GetPage(name: consultationDetailScreen, page: () => ConsultationDetailScreen()),

];
