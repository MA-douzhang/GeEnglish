import 'package:auto_route/auto_route.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:ge_english/common/apis/word.dart';
import 'package:ge_english/common/values/colors.dart';

import '../../common/entitys/word.dart';
import '../../common/utils/screen.dart';
import '../../common/widgets/app.dart';

@RoutePage(name: "searchResultRoute")
class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Widget appBarTitle = Text(
    "搜词",
    style: TextStyle(
      color: AppColors.primaryText,
      fontFamily: 'gengsha',
      fontSize: duSetFontSize(18.0),
      fontWeight: FontWeight.w600,
    ),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: AppColors.primaryText,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool? _IsSearching;

  bool isPerformingRequest = false;
  List<WordData> _items = [];
  int page = 1;
  int pages = 1;

  Future<void> fetchData() async {
    if (!isPerformingRequest && page <= pages) {
      setState(() {
        isPerformingRequest = true;
      });
      var tmp = await getSearchData(
          context: context,
          params: SearchDataRequest(
              page: page, size: 20, word: _searchQuery.value.text));

      setState(() {
        pages = tmp.pages!;
        page = (tmp.pageNum! + 1);
        _items.addAll(tmp.list as Iterable<WordData>);
        isPerformingRequest = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
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
      ),
    );
  }

  Widget _displayList(int index) {
    return Container(
        padding: EdgeInsets.only(left: 2.0, bottom: 2.0, right: 2.0),
        child: Column(children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[_Flexible(index)],
              ),
            ),
          ),
          SizedBox(height: duSetHeight(5)),
        ]));
  }

  Widget _Flexible(int index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _items[index].word as String,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text("翻译:${_items[index].translation}",
              style: TextStyle(color: Colors.grey[600], fontSize: 18.0)),
        ],
      ),
    );
  }

  PreferredSizeWidget buildBar(BuildContext context) {
    return transparentAppBar(
        context: context,
        title: appBarTitle,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(
                    Icons.close,
                    color: AppColors.primaryText,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                    ),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: AppColors.primaryText),
                        hintText: "搜索...",
                        hintStyle: TextStyle(color: AppColors.primaryText)),
                    onSubmitted: (String val) async {
                      EasyDialog(
                              title: const Text("请稍等"),
                              description: const Text("搜索中"),
                              closeButton: false)
                          .show(context);
                      await  fetchData();
                      AutoRouter.of(context).pop();
                    },
                  );
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: AppColors.primaryText,
      );
      this.appBarTitle = new Text(
        "搜索",
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: 'gengsha',
          fontSize: duSetFontSize(18.0),
          fontWeight: FontWeight.w600,
        ),
      );
      _searchQuery.clear();
    });
  }
}
