import 'package:sqflite/sqflite.dart';

class Dbservice {
  //initialize database
  Future<Database> initDataBase() async {
    final database = await openDatabase(
      'tasks.db',
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE data(id INTEGER PRIMARY KEY, task TEXT NOT NULL)",
        );
      },
      version: 1,
    );
    return database;
  }

  // Method to add data into database
  Future<void> addTask(String data) async {
    final database = await initDataBase();
    await database.insert(
      'data',
      {'task': data},
    );
  }

  //method to get data from database
  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final database = await initDataBase();
    final task = await database.query('data');
    return task;
  }

  //method to delete data from database
  Future<void> deleteTask(int id) async {
    final database = await initDataBase();
    await database.delete(
      'data',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //method to edit data in database
  Future<void> editTask(int id, String task) async {
    final database = await initDataBase();
    await database.update(
      'data',
      {'task': task},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
