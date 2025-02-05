class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? createdAt;
  int? expenses;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.createdAt,
    this.expenses,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      createdAt: json['created_at'],
      expenses: json['expenses'] ?? 0, // إذا لم يكن موجودًا، اجعله 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'created_at': createdAt,
      'expenses': expenses,
    };
  }
}
