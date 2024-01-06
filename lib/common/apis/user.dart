import 'package:flutter/material.dart';
import 'package:ge_english/common/entitys/user.dart';
import 'package:ge_english/common/utils/http.dart';


/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({
    required BuildContext context,
    UserLoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/account/token',
      context: context,
      params: params,
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// 登录
  static Future<UserLoginResponseEntity> register({
    required BuildContext context,
    UserRegisterRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/account',
      context: context,
      params: params,
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// 更新
  static void update(
    BuildContext context,
    UserUpdateEntity params,
  ) async {
    var response = await HttpUtil().patch(
      '/account',
      context: context,
      params: params,
    );
  }
}
