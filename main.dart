import 'package:dashboard_app/dashboard.dart';
import 'package:flutter/material.dart';
// ignore: duplicate_import
import 'dashboard.dart';
// ignore: unused_import
import 'add_student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لوحة التحكم',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'اسم المستخدم'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  if (usernameController.text == 'admin' &&
                      passwordController.text == '2462001') {
                    // توجيه إلى صفحة الداش بورد
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  } else {
                    // عرض رسالة خطأ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('اسم المستخدم أو كلمة المرور غير صحيحة')),
                    );
                  }
                },
                child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
