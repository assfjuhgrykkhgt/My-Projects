import 'package:flutter/material.dart';
import 'login_page.dart'; // استيراد صفحة تسجيل الدخول
import 'register_page.dart'; // استيراد صفحة إنشاء الحساب
import 'quick_lesson_page.dart'; // استيراد صفحة حصة على الطاير

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // لإخفاء الشعار في الزاوية
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              mainAxisAlignment: MainAxisAlignment.center, // خلي النص والأزرار في نص الصفحة
              children: [
                // النص
                const Text(
                  'منصة التيسير',
                  style: TextStyle(
                    fontSize: 70, // حجم أكبر للنص
                    color: Colors.white,
                    fontFamily: 'ArabicFont', // حط اسم الخط العربي هنا
                    fontWeight: FontWeight.bold, // خط عريض
                    letterSpacing: 2.0, // تباعد بين الحروف
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.orange, // تحديد باللون البرتقالي
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // زرار إنشاء حساب
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()), // يروح لصفحة إنشاء حساب
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40), // حجم أكبر للأزرار
                  ),
                  child: const Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      fontSize: 30, // حجم أكبر للنص
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // زرار تسجيل الدخول
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()), // يروح لصفحة تسجيل الدخول
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40), // حجم أكبر للأزرار
                  ),
                  child: const Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontSize: 30, // حجم أكبر للنص
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // زرار حصة على الطاير
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuickLessonPage()), // يروح لصفحة الحصة على الطاير
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40), // حجم أكبر للأزرار
                  ),
                  child: const Text(
                    'حصة على الطاير',
                    style: TextStyle(
                      fontSize: 30, // حجم أكبر للنص
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
