import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../../models/doctor_model.dart';

//
//  DatabaseHelper class instance variable.
DatabaseHelper _databaseHelper = DatabaseHelper();

//
//  Table name.
const String _userTableName = 'doctor';

//
//  Table Columns.
const String _doctorsId = 'id';
const String _doctorsFName = 'doctors_fName';
const String _doctorsLName = 'doctors_lName';
const String _doctorsEmail = 'doctors_email';
const String _doctorsPhone = 'doctors_phone';
const String _doctorsGender = 'doctors_gender';
const String _doctorsSpecialty = 'doctors_specialty';
const String _doctorsAddress = 'doctors_address';
const String _doctorsCity = 'doctors_city';
const String _doctorsState = 'doctors_state';
const String _doctorsCountry = 'doctors_country';
const String _doctorsHospital = 'doctors_hospital';
const String _doctorsSYOP = 'doctors_SYOP';
const String _doctorBioInfo = 'doctors_bioInfo';
const String _doctorsAvatar = 'doctors_avatar';
const String _doctorsRating = 'doctors_rating';
const String _userType = 'user_type';
const String _createdAt = 'createdAt';
const String _updatedAt = 'updatedAt';
const String _token = 'token';

//
//  Create Doctor's Table.
const String createDoctorTable = """CREATE TABLE $_userTableName(
    $_doctorsId TEXT NOT NULL,
    $_doctorsFName TEXT NOT NULL,
    $_doctorsLName TEXT NOT NULL,
    $_doctorsEmail TEXT NOT NULL,
    $_doctorsPhone TEXT NOT NULL,
    $_doctorsGender TEXT NOT NULL,
    $_doctorsSpecialty TEXT NOT NULL,
    $_doctorsAddress TEXT NOT NULL,
    $_doctorsCity TEXT NOT NULL,
    $_doctorsState TEXT NOT NULL,
    $_doctorsCountry TEXT NOT NULL,
    $_doctorsHospital TEXT NOT NULL,
    $_doctorsSYOP TEXT NOT NULL,
    $_doctorBioInfo TEXT NOT NULL,
    $_doctorsAvatar TEXT NOT NULL,
    $_doctorsRating TEXT,
    $_userType TEXT NOT NULL,
    $_createdAt TEXT NOT NULL,
    $_updatedAt TEXT NOT NULL,
    $_token TEXT
)""";

//
//
//  Insert a single Doctor into the SQFLite Database.
Future<int> saveDoctorToDatabase(Doctor doctor) async {
  try {
    var dbClient = await _databaseHelper.database;
    //  First check if Doctor exists.
    var response = await dbClient.query(
      _userTableName,
      columns: null,
      where: "$_doctorsId = ?",
      whereArgs: [doctor.id]
    );
    if (response.isNotEmpty) {
      return 0;
    }
    return await dbClient.insert(
      _userTableName,
      doctor.toMap(),
    );
  } catch (e) {
    // print("SQFLITE::: $e");
    throw Exception(e);
  }
}

//
//  get All Doctors.
Future<List<Map<String, dynamic>>> getAllDoctorsFromDatabase() async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.rawQuery("SELECT * FROM $_userTableName");
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Get single saved Doctor.
Future<Doctor?> getSingleDoctorFromDatabase(String doctorsId) async {
  try {
    var dbClient = await _databaseHelper.database;
    var response = await dbClient.query(
      _userTableName,
      columns: null,
      where: "$_doctorsId = ?",
      whereArgs: [doctorsId],
    );

    if (response.isNotEmpty) {
      return Doctor.fromMap(response.first);
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Update single Doctor.
Future<int> updateSingleDoctorInDatabase(Doctor doctor) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.update(
      _userTableName,
      doctor.toMap(),
      where: "$_doctorsId = ?",
      whereArgs: [doctor.id],
    );
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Delete single Doctor.
Future<int> deleteSingleDoctorFromDatabase(String doctorsId) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.delete(
      _userTableName,
      where: "$_doctorsId = ?",
      whereArgs: [doctorsId],
    );
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Get Doctors count.
Future<int?> getAllDoctorsCount() async {
  try {
    var dbClient = await _databaseHelper.database;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $_userTableName"),
    );
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Close Database.
Future<void> closeDatabase() async {
  var dbClient = await _databaseHelper.database;
  dbClient.close();
}