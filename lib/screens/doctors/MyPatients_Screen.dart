import 'package:flutter/material.dart';

class MyPatientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            Navigator.pop(context),
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'My Doctors',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5.0,
            child: ListTile(
              contentPadding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 0.0,
                right: 20.0,
              ),
              leading: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.grey,
                child: Image.asset('images/doctor_male_avatar_2.png'),
              ),
              title: Text(
                'Dr John Deo',
                style: TextStyle(
                    color: Color(0xff19769F),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Unity Hospital'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.my_location,
                    color: Color(0xff19769F),
                  ),
                  Text('16km'),
                ],
              ),
            ),
          );
        },
        itemCount: 4,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
