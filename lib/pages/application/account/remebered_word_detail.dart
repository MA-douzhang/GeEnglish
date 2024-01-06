import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/apis/word.dart';
import '../../../common/entitys/word.dart';
import '../../../common/utils/screen.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/app.dart';
import '../../../global.dart';

@RoutePage(name: "remeberedWordDetailRoute")
class RemeberedWordDetail extends StatefulWidget {
  const RemeberedWordDetail({super.key});

  @override
  State<StatefulWidget> createState()  => _RemeberedWordDetailState();


}

class _RemeberedWordDetailState extends State<RemeberedWordDetail> {
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;
  List<ListElement> _items = [];
  int page = 1;
  int pages = 1;

  void fetchData() async {
    if (!isPerformingRequest && page <= pages) {
      setState(() {
        isPerformingRequest = true;
      });
      var tmp = await getSelfData(
          context: context,
          params: RemeberedWordPageRequest(
              userName: Global.profile?.displayName, page: page, size: 20));

      setState(() {
        pages = tmp.pages!;
        page = tmp.pageNum! + 1;
        _items.addAll(tmp.list as Iterable<ListElement>);
        isPerformingRequest = false;
      });
    }
  }

  initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
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
          Text("翻译:${_items[index].translation}\n已通过次数:${_items[index].times}",
              style: TextStyle(color: Colors.grey[600], fontSize: 18.0)),
        ],
      ),
    );
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
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _displayList(index);
                },
                controller: _scrollController,
              ),
            )
          ],
        ),
      ),
    );
  }
}