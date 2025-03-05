import 'package:flutter/material.dart';
import 'package:dashboard_app/add_student.dart';
import 'package:dashboard_app/delete_student.dart';
import 'package:dashboard_app/add_teacher.dart';
import 'package:dashboard_app/add_subject.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة التحكم'),
        backgroundColor: Colors.orange,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'إضافة طالب',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.person_add, color: Colors.orange),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddStudentPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'حذف طالب',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.delete, color: Colors.red),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeleteStudentPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'إضافة معلم',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.person_add_alt, color: Colors.blue),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTeacherPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'إضافة مادة',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.book, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSubjectPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
