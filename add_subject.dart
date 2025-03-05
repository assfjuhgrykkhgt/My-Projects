import 'package:flutter/material.dart';
import 'database_helper.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper();
  String subjectName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة مادة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'اسم المادة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المادة';
                  }
                  return null;
                },
                onChanged: (value) => subjectName = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // التحقق من نجاح الإدخال
                    bool success = await dbHelper.insertSubject({'name': subjectName});
                    
                    if (success) {
                      // إذا تمت الإضافة بنجاح، إظهار Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تمت إضافة المادة بنجاح')),
                      );
                      // إعادة تعيين الحقل بعد الإضافة
                      setState(() {
                        subjectName = '';
                      });
                    } else {
                      // إذا فشلت الإضافة (المادة موجودة بالفعل)، إظهار رسالة خطأ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('المادة موجودة بالفعل')),
                      );
                    }
                  }
                },
                child: Text('إضافة مادة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
