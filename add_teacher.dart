import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:math';

class AddTeacherPage extends StatefulWidget {
  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper();

  String name = '';
  String nationalId = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String birthDate = '';
  String governorate = '';  // المحافظة تكتب يدويًا
  int numSchools = 0;
  List<String> schools = [];
  String gender = 'ذكر';
  String subject = '';  // المادة يتم جلبها من قاعدة البيانات
  String grade = '';
  List<Map<String, dynamic>> branches = [];
  bool showPassword = false;
  List<String> availableSubjects = []; // لتخزين المواد من قاعدة البيانات

  // لتوليد كود المعلم العشوائي
  String generateTeacherCode() {
    Random random = Random();
    String code = "10"; // أول رقمين ثابتين للمعلمين
    for (int i = 0; i < 8; i++) {
      code += random.nextInt(10).toString();
    }
    return code;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // دالة لتحميل البيانات من قاعدة البيانات
  Future<void> _loadData() async {
    // جلب المواد من قاعدة البيانات
    List<Map<String, dynamic>> subjects = await dbHelper.getSubjects();
    setState(() {
      availableSubjects = subjects.cast<String>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة معلم'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // الاسم
              TextFormField(
                decoration: InputDecoration(labelText: 'اسم المعلم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المعلم';
                  }
                  return null;
                },
                onChanged: (value) => name = value,
              ),
              
              // الرقم القومي
              TextFormField(
                decoration: InputDecoration(labelText: 'الرقم القومي'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.length != 14) {
                    return 'يرجى إدخال الرقم القومي المكون من 14 رقمًا';
                  }
                  return null;
                },
                onChanged: (value) => nationalId = value,
              ),

              // البريد الإلكتروني
              TextFormField(
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'يرجى إدخال بريد إلكتروني صالح';
                  }
                  return null;
                },
                onChanged: (value) => email = value,
              ),

              // كلمة السر وتأكيدها
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'كلمة السر',
                  suffixIcon: IconButton(
                    icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !showPassword,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'كلمة السر يجب أن تكون على الأقل 6 أحرف';
                  }
                  return null;
                },
                onChanged: (value) => password = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'تأكيد كلمة السر'),
                obscureText: !showPassword,
                validator: (value) {
                  if (value != password) {
                    return 'كلمة السر غير متطابقة';
                  }
                  return null;
                },
                onChanged: (value) => confirmPassword = value,
              ),

              // تاريخ الميلاد
              TextFormField(
                decoration: InputDecoration(labelText: 'تاريخ الميلاد'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      birthDate = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(text: birthDate),
              ),

              // المحافظة (يتم كتابتها يدويًا)
              TextFormField(
                decoration: InputDecoration(labelText: 'المحافظة'),
                onChanged: (value) => governorate = value,
              ),

              // عدد المدارس
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'عدد المدارس'),
                items: List.generate(11, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value == 10 ? 'لا يوجد' : value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    numSchools = value!;
                    schools = List.generate(numSchools, (_) => '');
                  });
                },
              ),

              // إدخال المدارس
              ...List.generate(numSchools, (index) {
                return TextFormField(
                  decoration: InputDecoration(labelText: 'اسم المدرسة ${index + 1}'),
                  onChanged: (value) => schools[index] = value,
                );
              }),

              // النوع
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'النوع'),
                items: ['ذكر', 'أنثى'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => gender = value!,
              ),

              // المادة (يتم جلبها من قاعدة البيانات)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'المادة'),
                items: availableSubjects.isNotEmpty
                    ? availableSubjects.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : [],
                onChanged: (value) => subject = value!,
              ),

              // الصف
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'الصف'),
                items: ['الأول الثانوي', 'الثاني الثانوي', 'الثالث الثانوي'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => grade = value!,
              ),

              // زر الحفظ
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String teacherCode = generateTeacherCode();
                    await dbHelper.insertTeacher({
                      'name': name,
                      'nationalId': nationalId,
                      'email': email,
                      'password': password,
                      'birthDate': birthDate,
                      'governorate': governorate,
                      'schools': schools.join(', '),
                      'gender': gender,
                      'subject': subject,
                      'grade': grade,
                      'branches': branches.map((e) => '${e['name']} - ${e['price']} جنيه').join(', '),
                      'teacherCode': teacherCode,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('تم تسجيل المعلم بنجاح. كود المعلم هو $teacherCode'),
                    ));
                  }
                },
                child: Text('تسجيل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
