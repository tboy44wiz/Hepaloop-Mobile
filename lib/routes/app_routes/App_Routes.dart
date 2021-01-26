import 'package:flutter/material.dart';
import 'package:hepaloop/routes/app_routes/App_Route_Names.dart';
import 'package:hepaloop/screens/AppEntrance_Screen.dart';
import 'package:hepaloop/screens/AppHome_Screen.dart';
import 'package:hepaloop/screens/auths/Login_Screen.dart';
import 'package:hepaloop/screens/auths/Signup_Screen.dart';
import 'package:hepaloop/screens/doctors/DoctorsDashBoard_Screen.dart';
import 'package:hepaloop/screens/doctors/MyPatients_Screen.dart';
import 'package:hepaloop/screens/doctors/update_doctor/UpdateDoctorsAddress_Screen.dart';
import 'package:hepaloop/screens/doctors/update_doctor/UpdateDoctorsBioData_Screen.dart';
import 'package:hepaloop/screens/patients/MyDoctors_Screen.dart';
import 'package:hepaloop/screens/patients/PatientsDashBoard_Screen.dart';
import 'package:hepaloop/screens/patients/update_patient/UpdatePatientBioData_Screen.dart';
import 'package:hepaloop/screens/pharmacy/PharmacyDashBoard_Screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String routeName = settings.name;
    final routeArguments = settings.arguments;

    //  Change Route Names;
    switch (routeName) {

      //////////////////////////////////////////////////////////////////////////
      //  Walk-Through Screens.
      case appHomeScreen:
        return MaterialPageRoute(builder: (context) => AppHomeScreen());
        break;

      case appEntryScreen:
        return MaterialPageRoute(builder: (context) => AppEntranceScreen());
        break;

      //////////////////////////////////////////////////////////////////////////
      //  Auth Screens.
      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;

      case signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
        break;

      //////////////////////////////////////////////////////////////////////////
      //  Doctors Screens.
      case doctorDashBoardScreen:
        return MaterialPageRoute(builder: (context) => DoctorDashBoardScreen());
        break;

      case myPatientScreen:
        return MaterialPageRoute(builder: (context) => MyPatientsScreen());
        break;

      case doctorBioDataScreen:
        return MaterialPageRoute(builder: (context) => null); // TODO
        break;

      case updateDoctorBioDataScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateDoctorsBioDataScreen(
            routeArguments: routeArguments,
          ),
        );
        break;

      case updateDoctorAddressScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateDoctorsAddressScreen(
            routeArguments: routeArguments,
          ),
        );
        break;

      //////////////////////////////////////////////////////////////////////////
      //  Patients Screens.
      case patientDashBoardScreen:
        return MaterialPageRoute(
            builder: (context) => PatientDashBoardScreen());
        break;

      case myDoctorScreen:
        return MaterialPageRoute(builder: (context) => MyDoctorsScreen());
        break;

      case patientBioDataScreen:
        return MaterialPageRoute(builder: (context) => null); // TODO
        break;

      case updatePatientBioDataScreen:
        return MaterialPageRoute(
            builder: (context) =>
                UpdatePatientBioDataScreen(routeArguments: routeArguments));
        break;

      case updatePatientAddressScreen:
        return MaterialPageRoute(builder: (context) => null); // TODO
        break;

      //////////////////////////////////////////////////////////////////////////
      //  Pharmacy Screens.
      case pharmacyDashBoardScreen:
        return MaterialPageRoute(
            builder: (context) => PharmacyDashBoardScreen());
        break;

      //  Hospitals Screens.
      case hospitalDashBoardScreen:
        return MaterialPageRoute(builder: (context) => null); // TODO
        break;

      default:
        return MaterialPageRoute(builder: (context) => null);
    }
  }
}
