class CovenantResponse {
  final bool success;
  final String msg;
  final CovenantData data;

  CovenantResponse({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory CovenantResponse.fromJson(Map<String, dynamic> json) {
    return CovenantResponse(
      success: json['success'],
      msg: json['msg'],
      data: CovenantData.fromJson(json['data']),
    );
  }
}

class CovenantData {
  final String employee;
  final int total;
  final List<CovenantItem> items;

  CovenantData({
    required this.employee,
    required this.total,
    required this.items,
  });

  factory CovenantData.fromJson(Map<String, dynamic> json) {
    return CovenantData(
      employee: json['employee'],
      total: json['total'],
      items: (json['data'] as List)
          .map((item) => CovenantItem.fromJson(item))
          .toList(),
    );
  }
}

class CovenantItem {
  final int id;
  final int amount;
  final String notes;
  final String? image;
  final String createdBy;
  final String createdAt;

  CovenantItem({
    required this.id,
    required this.amount,
    required this.notes,
    this.image,
    required this.createdBy,
    required this.createdAt,
  });

  factory CovenantItem.fromJson(Map<String, dynamic> json) {
    return CovenantItem(
      id: json['id'],
      amount: json['amount'],
      notes: json['notes'],
      image: json['image'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }
}
