import 'package:flutter/foundation.dart';

// 登录请求
class UserLoginRequestEntity {
  String name;
  String password;

  UserLoginRequestEntity({
    required this.name,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
      };
}

class UserRegisterRequestEntity {
  String email;
  String name;
  String password;

  UserRegisterRequestEntity({
    required this.email,
    required this.password,
    required this.name,
  });

  factory UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestEntity(
        email: json["email"],
        password: json["password"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
      };
}

// 更新请求
class UserUpdateEntity {
  String? displayName;
  int todayWords;
  int todayReviewWords;

  UserUpdateEntity({this.displayName, this.todayWords = 20,this.todayReviewWords=20});

  factory UserUpdateEntity.fromJson(Map<String, dynamic> json) =>
      UserUpdateEntity(
        displayName: json["name"],
        todayWords: json["todayWords"],
        todayReviewWords: json["todayReviewWords"],
      );

  Map<String, dynamic> toJson() =>
      {"name": displayName, "todayWords": todayWords,"todayReviewWords":todayReviewWords};
}

// 登录返回
class UserLoginResponseEntity {
  String accessToken;
  String? displayName;
  String? email;
  int? todayWords;
  int? todayReviewWords;
  String? avatar;

  UserLoginResponseEntity(
      {required this.accessToken,
      this.displayName,
      this.email,
      this.avatar,
      this.todayWords = 20,
      this.todayReviewWords=20});

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
          accessToken: json["token"],
          displayName: json["name"],
          avatar: json["avatar"],
          todayWords: json["todayWords"],
          todayReviewWords: json["todayReviewWords"],
          email: json["email"]);

  Map<String, dynamic> toJson() => {
        "token": accessToken,
        "name": displayName,
        "email": email,
        "avatar": avatar,
        "todayWords": todayWords,
        "todayReviewWords": todayReviewWords
      };
}
