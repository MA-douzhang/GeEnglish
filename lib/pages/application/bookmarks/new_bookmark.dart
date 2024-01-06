import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


import '../../../common/apis/article.dart';
import '../../../common/entitys/article.dart';
import '../../../common/utils/screen.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/app.dart';
import '../../../common/widgets/input.dart';
import '../../../global.dart';

@RoutePage(name: "newBookMarkRoute")
class NewBookMark extends StatefulWidget {
  const NewBookMark({super.key});

  @override
  State<StatefulWidget> createState() => _NewBookMarkState();


}

class _NewBookMarkState extends State<NewBookMark> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            AutoRouter.of(context).pop();
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              uploadArticle(
                  context: context,
                  params: UploadArticleRequest(
                      title: _titleController.value.text,
                      userName: Global.profile?.displayName,
                      content: _contentController.value.text));
              AutoRouter.of(context).pop();
            },
            child: const Text("发布",
                style: TextStyle(fontFamily: "gengsha", fontSize: 18)),
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            inputTextEdit(controller: _titleController, hintText: "标题"),
            Expanded(
              child: TextField(
                autofocus: false,
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "内容",
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: duSetFontSize(18),
                ),
                maxLines: 20,
                autocorrect: false,
                // // 自动纠正
                textInputAction: TextInputAction.newline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
