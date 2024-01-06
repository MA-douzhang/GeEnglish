import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ge_english/pages/application/application.dart';
import 'package:ge_english/pages/sign_in/sign_in.dart';

import '../../global.dart';
import '../welcome/welcome.dart';

@RoutePage(name: "indexPageRoute")
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});


  @override
  State<StatefulWidget> createState()  => _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812 - 44 - 34),
      splitScreenMode: true,
    );
    return Scaffold(
      body: Global.isFirstOpen == true
          ? const WelcomePage()
          : Global.isOfflineLogin == true ? const ApplicationPage() : const SignInPage(),
    );
  }
}
