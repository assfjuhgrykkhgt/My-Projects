import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إنشاء حساب',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedGovernorate;
  String? selectedGender;
  String? selectedSubject;
  String? selectedGrade;
  String? paymentMethod;
  File? _profileImage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _visaController = TextEditingController();
  bool _showCodeDialog = false;
  String? _generatedCode;

  // لمراقبة إظهار كلمة المرور
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> governorates = [
    'القاهرة', 'الجيزة', 'الإسكندرية', 'أسوان', 'الأقصر', 'سوهاج',
    'أسيوط', 'البحر الأحمر', 'البحيرة', 'بني سويف', 'بورسعيد',
    'دمياط', 'الدقهلية', 'الفيوم', 'الغربية', 'الإسماعيلية',
    'كفر الشيخ', 'مطروح', 'المنوفية', 'المنيا', 'الشرقية',
    'الوادي الجديد', 'قنا', 'القليوبية', 'السويس'
  ];

  final List<String> grades = [
    'الصف الأول الثانوي', 'الصف الثاني الثانوي', 'الصف الثالث الثانوي'
  ];

  final List<String> subjects = [
    'رياضيات', 'كيمياء', 'فيزياء', 'أحياء'
  ];

  String _generateRandomCode() {
    final Random random = Random();
    const int length = 8;
    const String chars = '0123456789';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void _registerStudent() {
    if (_formKey.currentState!.validate()) {
      final String code = _generateRandomCode();
      setState(() {
        _generatedCode = code;
        _showCodeDialog = true;
      });
    }
  }

  void _closeDialog() {
    setState(() {
      _showCodeDialog = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/333.jpg'), // خلفية الصفحة
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'انضم إلى منصة التيسير',
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'سجّل الآن واستفد من أفضل الدروس التعليمية!',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // زر اختيار الصورة بشكل احترافي
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: _profileImage != null
                          ? ClipOval(
                              child: Image.file(
                                _profileImage!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // حقل اختيار المحافظة
                  DropdownButtonFormField<String>(
                    value: selectedGovernorate,
                    decoration: InputDecoration(
                      labelText: 'المحافظة',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    dropdownColor: Colors.white.withOpacity(0.9),
                    items: governorates.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGovernorate = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'يرجى اختيار المحافظة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // حقل الاسم ورقم الهاتف
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'الاسم',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الاسم';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال رقم الهاتف';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // حقل البريد الإلكتروني والمدرسة
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _schoolController,
                          decoration: InputDecoration(
                            labelText: 'المدرسة',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال اسم المدرسة';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // حقل كلمة المرور وتأكيدها
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمات المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Dropdowns for gender, grade, subject, and payment method
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          decoration: InputDecoration(
                            labelText: 'النوع',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white.withOpacity(0.9),
                          items: ['ذكر', 'أنثى'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار النوع';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedGrade,
                          decoration: InputDecoration(
                            labelText: 'السنة الدراسية',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white.withOpacity(0.9),
                          items: grades.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGrade = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار السنة الدراسية';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Dropdown for subject and payment method
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedSubject,
                          decoration: InputDecoration(
                            labelText: 'المادة',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white.withOpacity(0.9),
                          items: subjects.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSubject = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار المادة';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: paymentMethod,
                          decoration: InputDecoration(
                            labelText: 'طريقة الدفع',
                            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white.withOpacity(0.9),
                          items: ['فودافون كاش', 'فيزا'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار طريقة الدفع';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Input for payment method details
                  if (paymentMethod == 'فودافون كاش')
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'رقم التحويل',
                        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم التحويل';
                        }
                        return null;
                      },
                    ),
                  if (paymentMethod == 'فيزا')
                    TextFormField(
                      controller: _visaController,
                      decoration: InputDecoration(
                        labelText: 'رقم الفيزا',
                        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الفيزا';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 20),

                  // زر إنشاء حساب
                  ElevatedButton(
                    onPressed: _registerStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'إنشاء حساب',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // رسالة تأكيد إنشاء الحساب
                  if (_showCodeDialog)
                    Column(
                      children: [
                        Text(
                          'تم إنشاء حسابك بنجاح. كودك: $_generatedCode',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _closeDialog,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'موافق',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}