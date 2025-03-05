import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('منصة التيسير'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'بيانات الطالب',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Card(
                color: Colors.black54,
                child: ListTile(
                  title: Text('الاسم: محمد أحمد', style: TextStyle(color: Colors.white)),
                  subtitle: Text('رقم الهاتف: 01030067339', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'الحصص',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: const Text('حصة رياضيات', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('التاريخ: 01/01/2023', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك إضافة الكود للانتقال إلى الحصة
                    },
                    child: const Text('الانطلاق'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'الشات',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: const Text('محادثة مع المعلم', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك إضافة الكود للانتقال إلى صفحة الشات
                    },
                    child: const Text('فتح الشات'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'الواجبات',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: const Text('واجب رياضيات', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('تاريخ التسليم: 05/01/2023', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك إضافة الكود لفتح الواجبات
                    },
                    child: const Text('عرض الواجب'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'الامتحانات',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: const Text('امتحان الفصل الدراسي الأول', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('تاريخ الامتحان: 10/01/2023', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك إضافة الكود لفتح الامتحان
                    },
                    child: const Text('ابدأ الامتحان'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'مسابقة التيسير',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: const Text('مسابقة الرياضيات', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('التسجيل مفتوح الآن!', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك إضافة الكود للانتقال إلى المسابقة
                    },
                    child: const Text('التسجيل'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
