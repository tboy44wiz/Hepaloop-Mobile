import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/doctor_DAO.dart';
import 'dao/individual_DAO.dart';
import 'dao/notification_DAO.dart';

class DatabaseHelper {
  //  Make this class a Singleton class.
  DatabaseHelper.internal();
  static final DatabaseHelper _databaseHelperInstance = DatabaseHelper.internal();

  //  Return the Instance of this Class.
  factory DatabaseHelper() => _databaseHelperInstance;

  /*
    Create a Database instance from SQFLite Library.
    Only allow a single open connection to the database.
  */
  static Database? _database;

  //
  //  Get the DataBase if available, else Initialize one.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDataBase();
    return _database!;
  }

  /*
   * Now to Create our Database, we need to get the Path/Directory where the
   * Database is to be created.
   * */
  _initDataBase() async {
    //  Get the Database Directory.
    String databasePath = await getDatabasesPath();
    final String path = join(databasePath, "hepaloop_database.db");
    //  OR
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // final String path = join(documentDirectory.path, "hepaloop_database.db");

    //  Now let's open the Database which is going to create it.
    var hepaLoopDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return hepaLoopDatabase;
  }

  /*
  * Calling the "onCreate" method which will create the Tables once the Database
  * is been opened/created.
  * */
  Future<void> _onCreate(Database database, int version) async {
    //  Create Table called "Notification".
    await database.execute(createDoctorTable);
    await database.execute(createIndividualTable);
    await database.execute(createNotificationTable);
  }

  Future<void> close() async => _database!.close();
}
