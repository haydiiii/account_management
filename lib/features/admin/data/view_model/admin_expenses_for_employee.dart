class EmployeeExpense {
  final String employee;
  final double total;
  final List<ExpenseData> data;

  EmployeeExpense({
    required this.employee,
    required this.total,
    required this.data,
  });

  factory EmployeeExpense.fromJson(Map<String, dynamic> json) {
    return EmployeeExpense(
      employee: json['employee'] ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ExpenseData.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employee": employee,
      "total": total,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class ExpenseData {
  final int id;
  final double amount;
  final String notes;
  final String? image;
  final String createdBy;
  final String createdAt;

  ExpenseData({
    required this.id,
    required this.amount,
    required this.notes,
    this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      notes: json['notes'] ?? '',
      image: json['image'],
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "notes": notes,
      "image": image,
      "created_by": createdBy,
      "created_at": createdAt,
    };
  }
}
