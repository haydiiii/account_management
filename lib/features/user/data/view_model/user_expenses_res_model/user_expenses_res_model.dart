import 'package:flutter/material.dart';

class ExpenseModel {
  final int id;
  final double amount;
  final String notes;
  final String? image;
  final String createdBy;
  final String createdAt;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.notes,
    this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      amount: (json['amount'] ?? 0).toDouble(), // تأمين ضد القيم null
      notes: json['notes'] ?? '',
      image: json['image'],
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class ExpensesResponse {
  final bool success;
  final String msg;
  final List<ExpenseModel> data;
  final int total;

  ExpensesResponse({
    required this.success,
    required this.msg,
    required this.data,
    required this.total,
  });

  factory ExpensesResponse.fromJson(Map<String, dynamic> json) {
    debugPrint('📡 البيانات المستلمة من API: $json');

    // التأكد من أن `data` هو Map وليس List
    Map<String, dynamic>? expensesData = json['data'];

    if (expensesData == null) {
      debugPrint('❌ البيانات المسترجعة غير صحيحة!');
      return ExpensesResponse(success: false, msg: json['msg'] ?? '', data: [], total: 0);
    }

    // استخراج قائمة المصروفات من `data`
    var list = expensesData['data']; 
    List<ExpenseModel> dataList = [];

    if (list is List) {
      dataList = list.map((i) => ExpenseModel.fromJson(i)).toList();
    } else {
      debugPrint('❌ البيانات داخل data ليست قائمة');
    }

    return ExpensesResponse(
      success: json['success'] ?? false,
      msg: json['msg'] ?? '',
      data: dataList,
      total: expensesData['total'] ?? 0,
    );
  }
}
