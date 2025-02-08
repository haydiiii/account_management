class ExpenseResponse {
  final bool success;
  final String msg;
  final ExpenseData data;

  ExpenseResponse({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      success: json['success'],
      msg: json['msg'],
      data: ExpenseData.fromJson(json['data']),
    );
  }
}

class ExpenseData {
  final String employee;
  final int total;
  final List<ExpenseItem> items;

  ExpenseData({
    required this.employee,
    required this.total,
    required this.items,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      employee: json['employee'],
      total: json['total'],
      items: (json['data'] as List)
          .map((item) => ExpenseItem.fromJson(item))
          .toList(),
    );
  }
}

class ExpenseItem {
  final int id;
  final int amount;
  final String notes;
  final String? image; // ✅ يدعم null بدون مشاكل
  final String createdBy;
  final String createdAt;

  ExpenseItem({
    required this.id,
    required this.amount,
    required this.notes,
    this.image, // ✅ جعل الحقل اختياري
    required this.createdBy,
    required this.createdAt,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      id: json['id'] ?? 0, // ✅ إذا لم يكن هناك ID يتم تعيين 0
      amount: json['amount'] ?? 0, // ✅ إذا لم يكن هناك مبلغ يتم تعيين 0
      notes:
          json['notes'] ?? 'بدون ملاحظات', // ✅ منع الخطأ عند عدم وجود ملاحظات
      image: json['image'] != null && json['image'] is String
          ? json['image']
          : null, // ✅ حل المشكلة نهائيًا
      createdBy: json['created_by'] ?? 'غير معروف', // ✅ تأمين البيانات ضد null
      createdAt:
          json['created_at'] ?? 'غير متاح', // ✅ تعيين قيمة افتراضية لتجنب الخطأ
    );
  }
}
