import 'dart:convert';

class EmployeeResponse {
  final bool success;
  final String msg;
  final List<Employee> data;

  EmployeeResponse({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        success: json["success"],
        msg: json["msg"],
        data: List<Employee>.from(json["data"].map((x) => Employee.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Employee {
  final int id;
  final String name;
  final int totalAmount;

  Employee({
    required this.id,
    required this.name,
    required this.totalAmount,
  });

  // ✅ Added `fromJson` to support direct JSON parsing
  factory Employee.fromJson(Map<String, dynamic> json) => Employee.fromMap(json);

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "total_amount": totalAmount,
      };
}
