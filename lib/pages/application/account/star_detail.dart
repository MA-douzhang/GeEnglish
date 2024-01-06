import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ge_english/common/apis/translate.dart';
import 'package:ge_english/common/entitys/translate.dart';
import 'package:ge_english/common/provider/app.dart';
import 'package:ge_english/global.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/screen.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/app.dart';

@RoutePage(name: "starDetailsRoute")
class StarDetails extends StatefulWidget {
  const StarDetails({super.key});

  @override
  State<StatefulWidget> createState() => _StarDetailsState();


}

class _StarDetailsState extends State<StarDetails> {
  List<Datum> _items = [];
  AppState? appState;

  void fetData() async {
    var tmp = await starDetailData(
        context: context, name: Global.profile?.displayName);
    setState(() {
      _items = tmp.data!;
    });
  }

  initState() {
    fetData();
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
                children: <Widget>[_Flexible(index), _collection(index)],
              ),
            ),
          ),
          SizedBox(height: duSetHeight(5)),
        ]));
  }

  Widget _Flexible(int index) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _items[index].fromSentence as String,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(_items[index].toSentence as String,
              style: TextStyle(color: Colors.grey[600], fontSize: 18.0)),
        ],
      ),
    );
  }

  Widget _collection(int index) {
    return IconButton(
      onPressed: () {
        deleteTranslateData(context: context, id: _items[index].id);
        appState?.removeData(_items[index]);
        setState(() {
          _items.removeAt(index);
        });
      },
      icon: Icon(
        Icons.star,
        size: 25.0,
        color: Colors.yellow[600],
      ),
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
            icon: Icon(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
