import 'package:flutter/material.dart';
import 'database_helper.dart';

class DeleteStudentPage extends StatefulWidget {
  @override
  _DeleteStudentPageState createState() => _DeleteStudentPageState();
}

class _DeleteStudentPageState extends State<DeleteStudentPage> {
  List<Map<String, dynamic>> students = [];
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  void loadStudents() async {
    students = await dbHelper.getStudents();
    setState(() {});
  }

  void deleteStudent(int id) async {
    await dbHelper.deleteStudent(id);
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حذف طالب')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index]['name']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteStudent(students[index]['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
