
class ApiResponse {
    bool? success;
    Data? data;
    String? error;

    ApiResponse({
        this.success,
        this.data,
        this.error,
    });

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    UserModel? user;
    String? message;

    Data({
        this.user,
        this.message,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "message": message,
    };
}

class UserModel {
    int? userId;
    String? name;
    int? age;
    String? profession;
    String? profileImage;

    UserModel({
        this.userId,
        this.name,
        this.age,
        this.profession,
        this.profileImage,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        name: json["name"],
        age: json["age"],
        profession: json["profession"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "age": age,
        "profession": profession,
        "profile_image": profileImage,
    };
}
