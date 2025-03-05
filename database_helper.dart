import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'control_panel.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            password TEXT,
            school TEXT,
            province TEXT,
            year TEXT,
            code TEXT UNIQUE
          )
        ''');

        await db.execute(''' 
          CREATE TABLE teachers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            nationalId TEXT,
            email TEXT,
            password TEXT,
            birthDate TEXT,
            governorate TEXT,
            schools TEXT,
            gender TEXT,
            subject TEXT,
            grade TEXT,
            branches TEXT,
            teacherCode TEXT UNIQUE
          )
        ''');

        await db.execute(''' 
          CREATE TABLE subjects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
    );
  }

  // دالة لإدخال طالب
  Future<int> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    return await db.insert('students', student);
  }

  // دالة لإدخال معلم
  Future<int> insertTeacher(Map<String, dynamic> teacher) async {
    final db = await database;
    return await db.insert('teachers', teacher);
  }

  // دالة لإدخال مادة مع التحقق
  Future<bool> insertSubject(Map<String, dynamic> subject) async {
    try {
      final db = await database;
      int result = await db.insert('subjects', subject);
      // إذا كانت النتيجة أكبر من 0، فهذا يعني أن الإدخال تم بنجاح
      return result > 0;
    } catch (e) {
      // في حالة حدوث خطأ، طباعة الخطأ
      print('Error inserting subject: $e');
      return false;
    }
  }

  // دالة لاسترجاع كل الطلاب
  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  // دالة لاسترجاع كل المعلمين
  Future<List<Map<String, dynamic>>> getTeachers() async {
    final db = await database;
    return await db.query('teachers');
  }

  // دالة لاسترجاع كل المواد
  Future<List<Map<String, dynamic>>> getSubjects() async {
    final db = await database;
    return await db.query('subjects');
  }

  // دالة لحذف طالب بواسطة معرفه
  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  // دالة لحذف معلم بواسطة معرفه
  Future<int> deleteTeacher(int id) async {
    final db = await database;
    return await db.delete('teachers', where: 'id = ?', whereArgs: [id]);
  }

  // دالة لحذف مادة بواسطة معرفها
  Future<int> deleteSubject(int id) async {
    final db = await database;
    return await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }

  // دالة لتحديث بيانات الطالب
  Future<int> updateStudent(int id, Map<String, dynamic> student) async {
    final db = await database;
    return await db.update('students', student, where: 'id = ?', whereArgs: [id]);
  }

  // دالة لتحديث بيانات المعلم
  Future<int> updateTeacher(int id, Map<String, dynamic> teacher) async {
    final db = await database;
    return await db.update('teachers', teacher, where: 'id = ?', whereArgs: [id]);
  }

  // دالة لتحديث بيانات المادة
  Future<int> updateSubject(int id, Map<String, dynamic> subject) async {
    final db = await database;
    return await db.update('subjects', subject, where: 'id = ?', whereArgs: [id]);
  }
}
