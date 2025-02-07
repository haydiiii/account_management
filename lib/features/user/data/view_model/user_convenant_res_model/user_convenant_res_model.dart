import 'package:flutter/material.dart';

class UserConvenatresModel {
  final int total;
  final List<UserConvenatresItem> data;

  UserConvenatresModel({
    required this.total,
    required this.data,
  });

  factory UserConvenatresModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data']['data']; // هنا تم تعديل مسار البيانات
    List<UserConvenatresItem> covenantList = [];

    if (dataList is List) {
      covenantList =
          dataList.map((item) => UserConvenatresItem.fromJson(item)).toList();
    } else {
      debugPrint('❌ البيانات داخل `data` ليست قائمة!');
    }

    return UserConvenatresModel(
      total: json['data']['total'] ?? 0, // استخراج `total` بشكل صحيح
      data: covenantList,
    );
  }
}

class UserConvenatresItem {
  final int id;
  final int amount;
  final String notes;
  final String image;
  final String createdBy;
  final String createdAt;

  UserConvenatresItem({
    required this.id,
    required this.amount,
    required this.notes,
    required this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory UserConvenatresItem.fromJson(Map<String, dynamic> json) {
    return UserConvenatresItem(
      id: json['id'],
      amount: json['amount'],
      notes: json['notes'] ?? '',
      image: json['image'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
