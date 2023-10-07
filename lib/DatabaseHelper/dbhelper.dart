import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import '../classes/attendance.dart';
import '../classes/user.dart';
import 'package:path_provider/path_provider.dart';
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
        roll TEXT
      )
    ''');

    // Create the attendance table
    db.execute('''
      CREATE TABLE IF NOT EXISTS attendance (
        id INTEGER PRIMARY KEY,
        student_id INTEGER,
        date TEXT,
        presence INTEGER
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

  // Get all users
  Future<List<User>> getAllUser() async {
    final results = _database.select('SELECT * FROM users');
    return results.map((row) => User.fromJson(row)).toList();
  }
}
