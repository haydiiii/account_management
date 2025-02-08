import 'dart:convert';

class UserExpense {
  final int id;
  final String name;
  final int totalAmount;

  UserExpense({
    required this.id,
    required this.name,
    required this.totalAmount,
  });

  factory UserExpense.fromJson(Map<String, dynamic> json) {
    return UserExpense(
      id: json['id'],
      name: json['name'],
      totalAmount: json['total_amount'],
    );
  }
}

class EmployeeExpense {
  final String employee;
  final int total;
  final List<ExpenseDetail> data;

  EmployeeExpense({
    required this.employee,
    required this.total,
    required this.data,
  });

  factory EmployeeExpense.fromJson(Map<String, dynamic> json) {
    return EmployeeExpense(
      employee: json['employee'],
      total: json['total'],
      data: (json['data'] as List).map((e) => ExpenseDetail.fromJson(e)).toList(),
    );
  }
}

class ExpenseDetail {
  final int id;
  final int amount;
  final String notes;
  final String? image;
  final String createdBy;
  final String createdAt;

  ExpenseDetail({
    required this.id,
    required this.amount,
    required this.notes,
    this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory ExpenseDetail.fromJson(Map<String, dynamic> json) {
    return ExpenseDetail(
      id: json['id'],
      amount: json['amount'],
      notes: json['notes'],
      image: json['image'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }
}
