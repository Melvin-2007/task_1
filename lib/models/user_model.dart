
class UserModel {
    bool? success;
    Data? data;
    String? error;

    UserModel({
        this.success,
        this.data,
        this.error,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    User? user;
    String? message;

    Data({
        this.user,
        this.message,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "message": message,
    };
}

class User {
    int? userId;
    String? name;
    int? age;
    String? profession;
    String? profileImage;

    User({
        this.userId,
        this.name,
        this.age,
        this.profession,
        this.profileImage,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
