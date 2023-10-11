import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import '../classes/attendance.dart';
import '../classes/request.dart';
import '../classes/user.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  late Database _database;

  DatabaseHelper._internal();

  Future<void> openDatabase() async {
    final String dbName = 'attendanceAPP.db';

    final documentsPath = await getApplicationDocumentsDirectory();

    final dbPath = join(documentsPath.path, dbName);

    // Open the database at the specified path
    _database = sqlite3.open(dbPath);

    _createDb(_database);
  }

  void closeDatabase() {
    _database.dispose();
  }

  void _createDb(Database db) {
    // Create the user table
    db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phone TEXT,
        password TEXT,
        roll TEXT,
        imagePath TEXT DEFAULT 'assets/images/logo.png'
      )
    ''');

    // Create the attendance table
    db.execute('''
      CREATE TABLE IF NOT EXISTS attendance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER,
        date TEXT,
        presence TEXT
        
      )
    ''');

    //Create table for request
    db.execute('''
      CREATE TABLE IF NOT EXISTS request (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER,
        date TEXT,
        reason TEXT,
      )
    ''');
  }

  // Insert a user
  Future<int> insertUser(User user) async {
    final stmt = _database.prepare(
      'INSERT INTO users (name, email, phone, password, roll) VALUES (?, ?, ?, ?, ?)',
    );
    stmt.execute([user.name, user.email, user.phone, user.password, user.roll]);
    return _database.lastInsertRowId;
  }

  // Insert attendance data
  Future<int> insertAttendance(Attendance attendance) async {
    final stmt = _database.prepare(
      'INSERT INTO attendance (student_id, date, presence) VALUES (?, ?, ?)',
    );
    stmt.execute([attendance.studentId, attendance.date, attendance.presence]);
    return _database.lastInsertRowId;
  }

  //insert request data
  Future<int> insertRequest(Request request) async {
    final stmt = _database.prepare(
      'INSERT INTO request (student_id, date, reason) VALUES (?, ?, ?)',
    );
    stmt.execute([request.studentId, request.date, request.reason]);
    return _database.lastInsertRowId;
  }

  //get request data
  Future<List<Request>> getAllRequest() async {
    final results = _database.select('SELECT * FROM request');
    return results.map((row) => Request.fromJson(row)).toList();
  }

  //delete request data by id
  Future<void> deleteRequest(int id) async {
    final stmt = _database.prepare(
      'DELETE FROM request WHERE id = ?',
    );
    stmt.execute([id]);
  }


  // Get all users
  Future<List<User>> getAllUser() async {
    final results = _database.select('SELECT * FROM users');
    return results.map((row) => User.fromJson(row)).toList();
  }

  // Get all attendance
  Future<List<Attendance>> getAllAttendance() async {
    final results = _database.select('SELECT * FROM attendance');
    return results.map((row) => Attendance.fromJson(row)).toList();
  }

  // Update User Image
  Future<void> updateUserImage(int id, String imagePath) async {
    final stmt = _database.prepare(
      'UPDATE users SET imagePath = ? WHERE id = ?',
    );
    stmt.execute([imagePath, id]);
  }

  // Get User Image
  Future<String> getUserImage(int id) async {
    final results = _database.select('SELECT imagePath FROM users WHERE id = $id');
    return results.map((row) => row['imagePath'] as String).first;
  }

  // Delete attendance by ID
  Future<void> deleteAttendance(int id) async {
    final stmt = _database.prepare('DELETE FROM attendance WHERE id = ?');
    stmt.execute([id]);
  }

  List<Attendance> getAttendanceDetailsForStudent(int? studentId) {
    final results = _database.select('SELECT * FROM attendance WHERE student_id = $studentId');
    return results.map((row) => Attendance.fromJson(row)).toList();
  }
}
