import 'package:sqflite/sqflite.dart';

import '../../models/individual_model.dart';
import '../database_helper.dart';

//
//  DatabaseHelper class instance variable.
DatabaseHelper _databaseHelper = DatabaseHelper();

//
//  Table name.
const String _userTableName = 'individual';

//
//  Table Columns.
const String _individualsId = "id";
const String _individualsFName = 'individuals_fName';
const String _individualsLName = 'individuals_lName';
const String _individualsEmail = "individuals_email";
const String _individualsPhone = "individuals_phone";
const String _individualsGender = "individuals_gender";
const String _individualsDOB = "individuals_DOB";
const String _individualsAge = "individuals_age";
const String _individualsAddress = "individuals_address";
const String _individualsCity = "individuals_city";
const String _individualsState = "individuals_state";
const String _individualsCountry = "individuals_country";
const String _individualsHeight = "individuals_height";
const String _individualsWeight = "individuals_weight";
const String _individualsAvatar = "individuals_avatar";
const String _purposeForTreatment = "purpose_for_treatment";
const String _userType = "user_type";
const String _createdAt = "createdAt";
const String _updatedAt = "updatedAt";
const String _token = 'token';

//
//  Create Individual's Table.
const String createIndividualTable = """CREATE TABLE $_userTableName(
      $_individualsId TEXT NOT NULL,
      $_individualsFName TEXT NOT NULL,
      $_individualsLName TEXT NOT NULL,
      $_individualsEmail TEXT NOT NULL,
      $_individualsPhone TEXT NOT NULL,
      $_individualsGender TEXT NOT NULL,
      $_individualsDOB TEXT NOT NULL,
      $_individualsAge TEXT NOT NULL,
      $_individualsAddress TEXT NOT NULL,
      $_individualsCity TEXT NOT NULL,
      $_individualsState TEXT NOT NULL,
      $_individualsCountry TEXT NOT NULL,
      $_individualsHeight TEXT NOT NULL,
      $_individualsWeight TEXT NOT NULL,
      $_individualsAvatar TEXT NOT NULL,
      $_purposeForTreatment TEXT,
      $_userType TEXT NOT NULL,
      $_createdAt TEXT NOT NULL,
      $_updatedAt TEXT NOT NULL,
      $_token TEXT
)""";

//
//
//  Insert a single Individual into the SQFLite Database.
Future<int> saveIndividualToDatabase(Individual individual) async {
  try {
    var dbClient = await _databaseHelper.database;
    //  First check if Individual exists.
    var response = await dbClient.query(
        _userTableName,
        columns: null,
      where: "$_individualsId = ?",
      whereArgs: [individual.id],
    );
    if (response.isNotEmpty) {
      return 0;
    }
    return await dbClient.insert(
      _userTableName,
      individual.toMap(),
    );
  } catch (e) {
    print("SQFLITE::: $e");
    throw Exception(e);
  }
}

//
//  get All Individuals.
Future<List<Map<String, dynamic>>> getAllIndividualsFromDatabase() async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.rawQuery("SELECT * FROM $_userTableName");
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Get single saved Individual.
Future<Individual?> getSingleIndividualFromDatabase(int individualsId) async {
  try {
    var dbClient = await _databaseHelper.database;
    var response = await dbClient.query(
      _userTableName,
      columns: null,
      where: "$_individualsId = ?",
      whereArgs: [individualsId],
    );

    if (response.isNotEmpty) {
      return Individual.fromMap(response.first);
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Update single Individual.
Future<int> updateSingleIndividualInDatabase(Individual individual) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.update(
      _userTableName,
      individual.toMap(),
      where: "$_individualsId = ?",
      whereArgs: [individual.id],
    );
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Delete single Individual.
Future<int> deleteSingleIndividualFromDatabase(int individualsId) async {
  try {
    var dbClient = await _databaseHelper.database;
    return await dbClient.delete(
      _userTableName,
      where: "$_individualsId = ?",
      whereArgs: [individualsId],
    );
  } catch (e) {
    throw Exception(e);
  }
}

//
//  Get Individuals count.
Future<int?> getAllIndividualsCount() async {
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
