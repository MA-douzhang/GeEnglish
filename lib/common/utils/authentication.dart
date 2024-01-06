import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ge_english/common/router/router.gr.dart';
import 'package:ge_english/common/utils/utils.dart';
import 'package:ge_english/common/values/values.dart';
import 'package:ge_english/global.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = null;
}
// declare your route as a global vairable

/// 重新登录
Future goLoginPage(BuildContext context) async {
  await deleteAuthentication();
  // get the scoped router by calling
  AutoRouter.of(context).navigate(const SignInPageRoute());
// or using the extension

  // ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
  //     Routes.signInPageRoute, (Route<dynamic> route) => false);
}
