class Subject {
  final int id; // رقم تعريف المادة
  final String name; // اسم المادة
  final double price; // سعر المادة

  // Constructor لتسهيل إنشاء كائنات جديدة
  Subject({required this.id, required this.name, required this.price});

  // دالة لتحويل كائن إلى خريطة (Map) لاستخدامها في قاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // دالة لإنشاء كائن من خريطة (Map)
  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }
}
