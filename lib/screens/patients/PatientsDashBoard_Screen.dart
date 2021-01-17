import 'package:flutter/material.dart';
import 'package:hepaloop/models/Patient_Model.dart';
import 'package:hepaloop/screens/patients/MyDoctors_Screen.dart';

class PatientDashBoardScreen extends StatelessWidget {
  final Patient patientDetail;

  const PatientDashBoardScreen({Key key, this.patientDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _id = patientDetail.id;
    String _patientsName = patientDetail.patientsName;
    String _patientsEmail = patientDetail.patientsEmail;
    String _patientsAvatar = patientDetail.patientsAvatar;

    return Scaffold(
      //  Drawer
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
                          backgroundImage: NetworkImage(_patientsAvatar),
                          radius: 45.0,
                        ),
                        Text(
                          _patientsName,
                          style: TextStyle(
                            color: Color(0xff19769F),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _patientsEmail,
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
                        color: Colors.blue,
                        elevation: 5.0,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /*Positioned(
                      top: 50,
                      right: 65.0,
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        elevation: 5.0,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),*/
                  ],
                ))
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
          'Patients',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      //  Body.
      body: Container(
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
                              Text('My Doctors')
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
