import 'dart:convert';

class ExpenseResponse {
  final bool success;
  final String msg;
  final ExpenseData data;

  ExpenseResponse({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory ExpenseResponse.fromJson(String str) => 
      ExpenseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExpenseResponse.fromMap(Map<String, dynamic> json) => ExpenseResponse(
        success: json["success"],
        msg: json["msg"],
        data: ExpenseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "msg": msg,
        "data": data.toMap(),
      };
}

class ExpenseData {
  final String employee;
  final int total;
  final List<Expense> expenses;

  ExpenseData({
    required this.employee,
    required this.total,
    required this.expenses,
  });

  factory ExpenseData.fromMap(Map<String, dynamic> json) => ExpenseData(
        employee: json["employee"],
        total: json["total"],
        expenses:
            List<Expense>.from(json["data"].map((x) => Expense.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "employee": employee,
        "total": total,
        "data": List<dynamic>.from(expenses.map((x) => x.toMap())),
      };
}

class Expense {
  final int id;
  final int amount;
  final String notes;
  final String? image;  // `null` مسموح
  final String createdBy;
  final String createdAt;

  Expense({
    required this.id,
    required this.amount,
    required this.notes,
    this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory Expense.fromMap(Map<String, dynamic> json) => Expense(
        id: json["id"],
        amount: json["amount"],
        notes: json["notes"],
        image: json["image"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "notes": notes,
        "image": image,
        "created_by": createdBy,
        "created_at": createdAt,
      };
}
