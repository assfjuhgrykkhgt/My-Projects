import 'package:flutter/material.dart';
import 'dart:math';
import 'database_helper.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController studentPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  String selectedYear = 'الأول';
  String studentCode = '';

  void generateStudentCode() {
    studentCode = (10000000 + Random().nextInt(90000000)).toString();
    saveStudent();
  }

  void saveStudent() async {
    final studentData = {
      'name': studentNameController.text,
      'password': studentPasswordController.text,
      'school': schoolController.text,
      'province': provinceController.text,
      'year': selectedYear,
      'code': studentCode,
    };

    final dbHelper = DatabaseHelper();
    await dbHelper.insertStudent(studentData);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('كود الطالب'),
          content: Text('كود الطالب هو: $studentCode'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // امسح البيانات
                studentNameController.clear();
                studentPasswordController.clear();
                confirmPasswordController.clear();
                schoolController.clear();
                provinceController.clear();
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة طالب')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: studentNameController,
              decoration: InputDecoration(labelText: 'اسم الطالب'),
            ),
            TextField(
              controller: studentPasswordController,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'تأكيد كلمة المرور'),
              obscureText: true,
            ),
            TextField(
              controller: schoolController,
              decoration: InputDecoration(labelText: 'المدرسة'),
            ),
            TextField(
              controller: provinceController,
              decoration: InputDecoration(labelText: 'المحافظة'),
            ),
            DropdownButton<String>(
              value: selectedYear,
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: <String>['الأول', 'الثاني', 'الثالث']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                generateStudentCode();
              },
              child: Text('تسجيل الطالب'),
            ),
          ],
        ),
      ),
    );
  }
}
