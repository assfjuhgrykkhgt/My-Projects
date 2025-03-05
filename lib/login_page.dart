import 'package:flutter/material.dart';
import 'database_helper.dart'; // تأكد من استيراد ملف قاعدة البيانات

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _codeController = TextEditingController();

  Future<void> _login() async {
    final String code = _codeController.text;

    // هنا يمكنك إضافة الكود للتحقق من الكود المدخل
    final DatabaseHelper dbHelper = DatabaseHelper();
    final List<Map<String, dynamic>> students = await dbHelper.getStudents();

    // تحقق مما إذا كان الكود موجودًا في قائمة الطلاب
    final bool isValidCode = students.any((student) => student['code'] == code);

    if (isValidCode) {
      // إذا كان الكود صحيحًا، انتقل إلى الصفحة التالية أو اعرض رسالة نجاح
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
      );
      // هنا يمكنك الانتقال إلى الصفحة الرئيسية أو أي صفحة أخرى
    } else {
      // إذا كان الكود غير صحيح، اعرض رسالة خطأ
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الكود غير صحيح!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/333.jpg'), // مسار الصورة
                fit: BoxFit.cover,
              ),
            ),
          ),
          // النص والأزرار
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // مربع النص
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // خلفية شفافة
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'مرحبًا بكم في منصة التيسير! هنا ستجدون أفضل الدروس التعليمية التي تساعدكم على التفوق في دراستكم.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // الفورم
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _codeController,
                          maxLength: 8, // تحديد عدد الأحرف بـ 8
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'كودك',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, // خط عريض للأرقام
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // الزرار
                      ElevatedButton(
                        onPressed: _login, // استدعاء دالة تسجيل الدخول
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // حجم أصغر للأزرار
                        ),
                        child: const Text('الدخول', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // النص الإنجليزي في آخر الصفحة
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Text(
              'Developed by Eng. Mohamed Ayman Mahmoud\nPhone: 01030067339',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 243, 243, 243),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
