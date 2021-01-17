import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PharmacyDashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      //  Screen Body.
      body: Center(
        child: Text(
          'Pharmacy List',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
