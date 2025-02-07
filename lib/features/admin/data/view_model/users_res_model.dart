class UserResponseModel {
  final bool success;
  final String msg;
  final List<UserModel> data;

  UserResponseModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  // تحويل JSON إلى Object (Factory Constructor)
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      success: json['success'],
      msg: json['msg'],
      data: List<UserModel>.from(
        json['data'].map((user) => UserModel.fromJson(user)),
      ),
    );
  }
}

class UserModel {
  final int id;
  final String name;

  UserModel({
    required this.id,
    required this.name,
  });

  // تحويل JSON إلى Object (Factory Constructor)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
