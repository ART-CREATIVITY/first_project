import 'package:first_project/entities/taxpayer.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccess {

  static const String DATABASE = "my_db.db";
  static const int DB_VERSION = 1;
  static Database ?_database;
  Future<Database> connect() async{
    if(_database!=null)
      return _database!;
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/$DATABASE";
    _database = await openDatabase(path, version: DB_VERSION,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE ${Taxpayer.TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName VARCHAR(100), lastName VARCHAR(100), gender VARCHAR(20), address TEXT, phone VARCHAR(50), identifyPicture VARCHAR, email VARCHAR(50), birthDay DATETIME, bornAround bit)');

        });

    return _database!;

  }
}