import 'package:sqflite/sqflite.dart';

import '../screen/home.dart';

class FormProvider {
  late Database db;

  String formTableName = '''
      CREATE TABLE form(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT,
        user_dob TEXT,
        user_course TEXT,
        reg_time TEXT,
        reg_day TEXT,
        user_essay TEXT 
      )
    ''';

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(formTableName);
    });
  }

  Future<int> insert(AppFormData form) async {
    return await db.insert(formTableName, form.toMap());
  }
}
