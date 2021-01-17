import 'dart:convert';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:hepaloop/screens/patients/MyDoctors_Screen.dart';
import 'package:hepaloop/utils/App_SnakBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDashBoardScreen extends StatefulWidget {
  @override
  _DoctorDashBoardScreenState createState() => _DoctorDashBoardScreenState();
}

class _DoctorDashBoardScreenState extends State<DoctorDashBoardScreen> {
  //  Get the Initial State.
  @override
  void initState() {
    // TODO: implement initState
    _getDoctorsDetails();
    super.initState();
  }

  String _id = '';
  String _doctorsName = '';
  String _doctorsEmail = '';
  String _doctorsAvatar = '';

  //  Call the instance of AppSnackBar
  AppSnackBar _appSnackBar = AppSnackBar();

  void _getDoctorsDetails() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    var _usersData = _sharedPreferences.getString('loggedInUser');
    Map<String, dynamic> _decodedUSerData = jsonDecode(_usersData);

    setState(() {
      _id = _decodedUSerData['id'];
      _doctorsName = _decodedUSerData['doctorsName'];
      _doctorsEmail = _decodedUSerData['doctorsEmail'];
      _doctorsAvatar = _decodedUSerData['doctorsAvatar'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  Drawer.
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(_doctorsAvatar),
                      ),
                      Text(
                        _doctorsName,
                        style: TextStyle(
                          color: Color(0xff19769F),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _doctorsEmail,
                        style: TextStyle(
                          color: Color(0xff19769F),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -3.0,
                    right: -15.0,
                    child: RaisedButton(
                      onPressed: () {},
                      shape: CircleBorder(),
                      color: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.person),
              title: Text('My Profile'),
            )
          ],
        ),
      ),

      //  AppBar.
      appBar: AppBar(
        /*leading: InkWell(
          onTap: () => {print('Menu pressed...')},
          child: Image.asset('images/menu_icon.png'),
        ),*/
        title: Text(
          'DashBoard',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar:
            _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //  First Row.
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {},
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/first_aid_box.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('Record Details')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/send_report.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('HMO')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(10.0)),

              //  Second Row.
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyDoctorsScreen(),
                              ),
                            ),
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/surgeon.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('My Patients')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/medical_history.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('Appointments')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(10.0)),

              //  Third Row.
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/ambulance.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('Emergency')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Color(0xffa8ffea).withOpacity(0.7),
                        child: InkWell(
                          onTap: () => {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffa8ffea)),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/pill.png'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Text('Pharmacies')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //  Bottom Navigation Bar.
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => {
          if (index == 0)
            {print('Home pressed...')}
          else if (index == 1)
            {print('Menu pressed...')}
          else if (index == 2)
            {print('User pressed...')}
          else if (index == 3)
            {print('Others pressed...')}
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            title: Text('Menu'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            title: Text('Home'),
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.menu_open_sharp),
            title: Text('Other'),
          ),*/
        ],
        elevation: 25.0,
      ),
    );
  }
}

/*


setState(() {
      _id = _decodedUSerData['id'];
      _doctorsName = _decodedUSerData['doctorsName'];
      _doctorsEmail = _decodedUSerData['doctorsEmail'];
      _doctorsAvatar = _decodedUSerData['doctorsAvatar'];
    });

* */
