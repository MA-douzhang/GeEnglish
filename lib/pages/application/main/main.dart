import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ge_english/common/apis/word.dart';
import 'package:ge_english/common/entitys/word.dart';
import 'package:ge_english/common/provider/app.dart';
import 'package:ge_english/common/router/router.dart';
import 'package:ge_english/common/router/router.gr.dart';
import 'package:ge_english/common/utils/screen.dart';
import 'package:ge_english/common/values/colors.dart';
import 'package:ge_english/common/values/server.dart';
import 'package:ge_english/common/widgets/app.dart';
import 'package:ge_english/common/widgets/button.dart';
import 'package:ge_english/common/widgets/toast.dart';
import 'package:ge_english/global.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isShow = false;
  AppState? appState;
  List<WordData> data = [];
  int index = 0;
  String headmsg = "请稍等";
  bool _isResume = false;
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
        alignment: Alignment.center,
        color: AppColors.primaryBackground,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                title: const Text("Learn",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primaryElementText,
                        fontWeight: FontWeight.w500)),
                subtitle: Row(
                  children: <Widget>[
                    Text(
                      "${appState?.remainWords}/${Global.profile?.todayWords}",
                      style: const TextStyle(
                          color: Colors.orangeAccent, fontSize: 15),
                    ),
                  ],
                ),
                onTap: () {
                  AutoRouter.of(context).navigate(const LearnPageRoute());
                },
              ),
            )),
            Expanded(
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
                      title: const Text("Review",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryElementText,
                              fontWeight: FontWeight.w500)),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                            "${appState?.reReviewWords}/${Global.profile?.todayReviewWords}",
                            style: const TextStyle(
                                color: Colors.orangeAccent, fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        AutoRouter.of(context)
                            .navigate(const ReviewPageRoute());
                      },
                    ))),
          ],
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

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHead(),
        ],
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/back.png"),
        ),

      ),
    );
  }
}
