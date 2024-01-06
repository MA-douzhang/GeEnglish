import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:ge_english/common/router/router.gr.dart';

import '../../../common/apis/article.dart';
import '../../../common/entitys/article.dart';
import '../../../common/utils/screen.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/app.dart';
import '../../../global.dart';

@RoutePage(name: "myBookMarkRoute")
class MyBookMark extends StatefulWidget {
  const MyBookMark({super.key});

  @override
  State<StatefulWidget> createState() =>_MyBookMarkState();


}

class _MyBookMarkState extends State<MyBookMark> {
  bool isPerformingRequest = false;
  List<Author> _items = [];
  int page = 1;
  int pages = 1;

  void fetchData() async {
    if (!isPerformingRequest && page <= pages) {
      setState(() {
        isPerformingRequest = true;
      });
      var tmp = await getArticleNameData(
          context: context,
          params: ArticlePageNameRequest(
              page: page, size: 20, userName: Global.profile?.displayName));

      setState(() {
        pages = tmp.pages!;
        page = tmp.pageNum! + 1;
        _items.addAll(tmp.list as Iterable<Author>);
        isPerformingRequest = false;
      });
    }
  }

  initState() {
    super.initState();
    fetchData();
  }

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
                Navigator.pop(context);
              },
            )),
        body: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter(),
          onRefresh: () async {
            page = 1;
            pages = 1;
            _items.clear();
            fetchData();
          },
          onLoad: () async {
            fetchData();
          },
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (content, index) {
                  return _displayList(index);
                },
                childCount: _items.length,
              ),
            )
          ],
        ));
  }

  Widget _displayList(int index) {
    return Container(
        padding: EdgeInsets.only(left: 2.0, bottom: 2.0, right: 2.0),
        child: Column(children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_items[index].avatar as String),
              ),
              title: Text(
                "主题:${_items[index].title}",
                style: TextStyle(fontFamily: "gengsha"),
              ),
              subtitle: Text(
                "发布者:${_items[index].name}",
                style: TextStyle(fontFamily: "gengsha"),
              ),
              onTap: () {
                AutoRouter.of(context).push(BookMarkDetailRoute(author: _items[index]));
              //   ExtendedNavigator.rootNavigator.pushNamed(
              //       Routes.bookMarkDetailRoute,
              //       arguments: BookMarkDetailArguments(author: _items[index]));
              },
            ),
          ),
          SizedBox(height: duSetHeight(5)),
        ]));
  }
}
