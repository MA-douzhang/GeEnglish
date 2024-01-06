import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ge_english/common/apis/word.dart';
import 'package:ge_english/common/entitys/word.dart';
import 'package:ge_english/common/provider/app.dart';
import 'package:ge_english/common/utils/screen.dart';
import 'package:ge_english/common/values/colors.dart';
import 'package:ge_english/common/values/server.dart';
import 'package:ge_english/common/widgets/app.dart';
import 'package:ge_english/common/widgets/button.dart';
import 'package:ge_english/common/widgets/toast.dart';
import 'package:ge_english/global.dart';
import 'package:provider/provider.dart';

@RoutePage(name: "learnPageRoute")
class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<StatefulWidget> createState() => _LearnPageState();

}

class _LearnPageState extends State<LearnPage> {
  bool _isShow = false;
  AppState? appState;
  List<WordData> data = [];
  int index = 0;
  String headmsg = "请稍等";
  bool _isResume =false;
  String waitmsg = "点击此处查看释义";
  final _random = Random();
  AudioPlayer audio = AudioPlayer();

  int next(int min, int max) => min + _random.nextInt(max - min);

  void fetchData() async {
    var tmp = await getWordData(context: context);
    setState(() {
      data.addAll(tmp.data as Iterable<WordData>);
      index = next(0, data.length);
      headmsg = data[index].word as String;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  _buildHead() {
    return Center(
      child: Container(
        height: duSetHeight(120),
        alignment: Alignment.center,
        color: AppColors.primaryBackground,
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: AppColors.primaryElement,
          elevation: 10,
          // 阴影
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
//              side: BorderSide(color: Colors.green,width: 25),
          ),
//            borderOnForeground: false,
          child: ListTile(
            title: Text(headmsg,
                style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryElementText,
                    fontWeight: FontWeight.w500)),
            subtitle: Row(
              children: <Widget>[
                const Text("点击听读音:",
                    style: TextStyle(
                        color: AppColors.primaryElementText,
                        fontWeight: FontWeight.w500)),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  color: Colors.white,
                  onPressed: () async {
                      debugPrint("is $_isResume");
                      audio.stop();
                      await audio.play(
                          mode: PlayerMode.lowLatency,
                          UrlSource(YOUDAO_PRONUNCIATION_BASEURL + headmsg));
                      _isResume=true;
                    // if (res == 1) {
                    //   toastInfo(msg: "成功播放");
                    // } else {
                    //   toastInfo(msg: "播放失败");
                    // }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCard(String title, String subtitle) {
    return Card(
        child: ListTile(
      title: Text(
        title,
        style: const TextStyle(fontFamily: "gengsha"),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontFamily: "gengsha"),
      ),
    ));
  }

  _build_show() {
    return Expanded(
      child: Column(
        children: <Widget>[
          divider10Px(),
//          _buildCard("音标", "eɪ"),
          _buildCard(
              "翻译",
              data[index].translation as String ?? "暂无数据"),
          _buildCard(
              "当前/总计", "${appState?.remainWords}/${Global.profile?.todayWords}"),
          Container(
              height: duSetHeight(44),
              margin: EdgeInsets.only(top: duSetHeight(15)),
              child: Row(
                children: <Widget>[
                  btnFlatButtonWidget(
                      title: "知道",
                      onPressed: () async {
                        await uploadRemeberedWord(
                            context: context,
                            params: RemeberedWordRequest(
                                userName: Global.profile?.displayName,
                                wordId: data[index].id));
                        appState?.wordPlusOne();
                        data.removeAt(index);
                        index = next(0, data.length);
                        headmsg = data[index].word as String;
                        _isShow = false;
                        if (data.length <= 1) {
                          fetchData();
                        }
                      },
                      fontName: "gengsha",
                      gbColor: AppColors.primaryBackground,
                      fontColor: AppColors.primaryText,
                      width: duSetWidth(150)),
                  Spacer(),
                  btnFlatButtonWidget(
                      title: "不知道",
                      onPressed: () {
                        setState(() {
                          index = next(0, data.length);
                          headmsg = data[index].word as String;
                          _isShow = false;
                        });
                      },
                      fontName: "gengsha",
                      width: duSetWidth(150)),
                ],
              )),
        ],
      ),
    );
  }

  _build_hide() {
    return Expanded(
      child: Center(
          child: GestureDetector(
        child: Text(
          appState?.remainWords > Global.profile?.todayWords
              ? "今日的学习目标已达成"
              : waitmsg,
          style: const TextStyle(fontSize: 36, fontFamily: "gengsha"),
        ),
        onTap: () {
          if (data.length == null) {
            toastInfo(msg: "请稍等");
            return;
          }
          setState(() {
            _isShow = true;
          });
        },
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: transparentAppBar(
            context: context,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryText,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      body:
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHead(),
              _isShow ? _build_show() : _build_hide(),
            ],
          ),
        )
    );

  }
}
