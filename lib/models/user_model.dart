class ApiResponse {
  bool? success;
  Data? data;
  String? error;

  ApiResponse({required this.success, required this.data, required this.error});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );
}

class Data {
  UserModel? user;
  String? message;
  Data({required this.user, required this.message});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(user: json["user"] == null ? null : UserModel.fromJson(json["user"]), message: json["message"]);
  }
}

class UserModel {
  int userId;
  String name;
  int age;
  String profession;
  String profileImage;

  UserModel({
    required this.userId,
    required this.name,
    required this.age,
    required this.profession,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? 0,
      name: json["name"] ?? "",
      age: json["age"] ?? 0,
      profession: json["profession"] ?? "",
      profileImage: json["profile_image"] ?? "",
    );
  }
}
