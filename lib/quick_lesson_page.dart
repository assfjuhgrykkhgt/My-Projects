import 'package:flutter/material.dart';

class QuickLessonPage extends StatefulWidget {
  const QuickLessonPage({super.key});

  @override
  _QuickLessonPageState createState() => _QuickLessonPageState();
}

class _QuickLessonPageState extends State<QuickLessonPage> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startLesson() {
    if (_formKey.currentState!.validate()) {
      // هنا يمكنك إضافة الكود لبدء الحصة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم انطلاق الحصة!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حصه على الطاير'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/333.jpg'), // تأكد من وجود الصورة في مجلد assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'أدخل كود الحصة',
                      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: 'كودك',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.black54, // خلفية شفافة مع الظل
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كود الحصة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _startLesson,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // لون زر الانطلاق
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'انطلاق',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.launch, color: Colors.white), // أيقونة الصاروخ
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

