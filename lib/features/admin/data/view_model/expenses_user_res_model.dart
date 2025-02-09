class UserExpenseResponse {
  final bool success;
  final String msg;
  final List<UserExpense> data;

  UserExpenseResponse({required this.success, required this.msg, required this.data});

  factory UserExpenseResponse.fromJson(Map<String, dynamic> json) {
    return UserExpenseResponse(
      success: json['success'],
      msg: json['msg'],
      data: (json['data'] as List)
          .map((item) => UserExpense.fromJson(item))
          .toList(),
    );
  }
}

class UserExpense {
  final int id;
  final String name;
  final double totalAmount;

  UserExpense({required this.id, required this.name, required this.totalAmount});

  factory UserExpense.fromJson(Map<String, dynamic> json) {
    return UserExpense(
      id: json['id'],
      name: json['name'],
      totalAmount: (json['total_amount'] as num).toDouble(),
    );
  }
}
