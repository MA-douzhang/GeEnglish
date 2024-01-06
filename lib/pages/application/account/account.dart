import 'package:auto_route/auto_route.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ge_english/common/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../../../common/apis/user.dart';
import '../../../common/entitys/user.dart';
import '../../../common/provider/app.dart';
import '../../../common/utils/authentication.dart';
import '../../../common/utils/screen.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/shadows.dart';
import '../../../common/widgets/app.dart';
import '../../../common/widgets/input.dart';
import '../../../global.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState()  => _AccountPageState();


}

class _AccountPageState extends State<AccountPage> {
  TextEditingController _todayWordsController = TextEditingController();

  // 个人页面 头部
  Widget _buildUserHeader() {
    return Container(
      height: duSetWidth(268),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: duSetWidth(333),
              decoration: const BoxDecoration(
                color: AppColors.primaryBackground,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: duSetWidth(2),
                    decoration: const BoxDecoration(
                      color: AppColors.tabCellSeparator,
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            right: 20,
            bottom: 21,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 头像
                Container(
                  height: duSetWidth(198),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: duSetWidth(108),
                          height: duSetWidth(108),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: duSetWidth(108),
                                  height: duSetWidth(108),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      Shadows.primaryShadow,
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(duSetWidth(108) / 2)),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                  child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    Image.network(Global.profile?.avatar as String).image,
                              )),
                            ],
                          ),
                        ),
                      ),
                      // 文字
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 9),
                        child: Text(
                          Global.profile?.displayName as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Text(
                        Global.profile?.email as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 列表项
  Widget _buildCell({
    String? title,
    String? subTitle,
    int? number,
    bool hasArrow = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: duSetWidth(60),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // 背景
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: duSetWidth(60),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBackground,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: duSetWidth(1),
                      decoration: const BoxDecoration(
                        color: AppColors.tabCellSeparator,
                      ),
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
            // 右侧
            Positioned(
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 数字
                  number == null
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(right: 11),
                          child: Text(
                            number.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w400,
                              fontSize: duSetFontSize(18),
                            ),
                          ),
                        ),
                  // 箭头
                  hasArrow == false
                      ? Container()
                      : Container(
                          width: duSetWidth(24),
                          height: duSetWidth(24),
                          margin: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryText,
                          ),
                        ),
                ],
              ),
            ),

            // 标题
            title == null
                ? Container()
                : Positioned(
                    left: 20,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "gengsha",
                        fontWeight: FontWeight.w400,
                        fontSize: duSetFontSize(18),
                      ),
                    ),
                  ),

            // 子标题
            subTitle == null
                ? Container()
                : Positioned(
                    right: 20,
                    child: Text(
                      subTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "gengsha",
                        fontWeight: FontWeight.w400,
                        fontSize: duSetFontSize(18),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Text returnStyledText(String s) {
    return Text(s,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "gengsha",
          fontWeight: FontWeight.w400,
          fontSize: duSetFontSize(18),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildUserHeader(),
          divider10Px(),
          _buildCell(
              title: "目标单词数",
              number: Global.profile?.todayWords,
              hasArrow: true,
              onTap: () {
                print("tapped");
                EasyDialog(
                    title: returnStyledText("更改每日目标:"),
                    height: 220,
                    contentList: [
                      inputTextEdit(
                          controller: _todayWordsController,
                          hintText: "请输入更改过后的数值"),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                          // padding: const EdgeInsets.only(top: 8.0),
                          // textColor: AppColors.primaryText,
                          onPressed: () {
                            Global.profile?.todayWords =
                                int.parse(_todayWordsController.value.text);
                            Global.saveProfile(Global.profile as UserLoginResponseEntity);
                            UserAPI.update(
                                context,
                                UserUpdateEntity(
                                    displayName: Global.profile?.displayName,
                                    todayWords: Global.profile?.todayWords as int,
                                    todayReviewWords: Global.profile?.todayReviewWords as int));
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "好的",
                            textScaleFactor: 1.2,
                          ),
                        ),
                      ])
                    ]).show(context);
              }),
          _buildCell(
              title: "复习目标单词数",
              number: Global.profile?.todayReviewWords,
              hasArrow: true,
              onTap: () {
                print("tapped");
                EasyDialog(
                    title: returnStyledText("更改每日复习目标:"),
                    height: 220,
                    contentList: [
                      inputTextEdit(
                          controller: _todayWordsController,
                          hintText: "请输入更改过后的数值"),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                          // padding: const EdgeInsets.only(top: 8.0),
                          // textColor: AppColors.primaryText,
                          onPressed: () {
                            Global.profile?.todayReviewWords =
                                int.parse(_todayWordsController.value.text);
                            Global.saveProfile(Global.profile as UserLoginResponseEntity);
                            UserAPI.update(
                                context,
                                UserUpdateEntity(
                                    displayName: Global.profile?.displayName,
                                    todayWords: Global.profile?.todayWords as int,
                                    todayReviewWords: Global.profile?.todayReviewWords as int));
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "好的",
                            textScaleFactor: 1.2,
                          ),
                        ),
                      ])
                    ]).show(context);
              }),
          _buildCell(
            title: "今日已背单词",
            number: appState.remainWords == null ? 0 : appState.remainWords,
            hasArrow: true,
          ),
          _buildCell(
              title: "总共背诵单词",
              hasArrow: true,
              onTap: () {
                AutoRouter.of(context).push(const RemeberedWordDetailRoute());
                // ExtendedNavigator.rootNavigator
                //     .pushNamed(Routes.remeberedWordDetailRoute);
              }),
          divider10Px(),
          _buildCell(
              title: "我的动态",
              hasArrow: true,
              onTap: () {
                AutoRouter.of(context).push(const MyBookMarkRoute());
                // ExtendedNavigator.rootNavigator
                //     .pushNamed(Routes.myBookMarkRoute);
              }),
          _buildCell(
              title: "我的收藏",
              hasArrow: true,
              onTap: () {
                AutoRouter.of(context).push(const StarDetailsRoute());
                // ExtendedNavigator.rootNavigator
                //     .pushNamed(Routes.starDetailsRoute);
              }),
          divider10Px(),
          _buildCell(
            title: "墨水屏模式",
            hasArrow: true,
            onTap: () => appState.switchGrayFilter(),
          ),
          _buildCell(
            title: "登出",
            hasArrow: true,
            onTap: () => goLoginPage(context),
          ),
          divider10Px(),
        ],
      ),
    );
  }
}
