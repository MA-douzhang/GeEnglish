import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';


import '../../../common/apis/article.dart';
import '../../../common/entitys/article.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/app.dart';
import '../../../global.dart';

@RoutePage(name: "bookMarkDetailRoute")
class BookMarkDetail extends StatefulWidget {
  final Author author;

  const BookMarkDetail(this.author, {super.key});

  @override
  State<StatefulWidget> createState() => _BookMarkDetailState();


}

class _BookMarkDetailState extends State<BookMarkDetail> {
  bool isLike = false;
  int likeId = 0;

  void fetStatus() async {
    likeId = await getLikeStatus(
        context: context,
        params: LikeStatusRequest(
            id: widget.author.id, userName: Global.profile?.displayName));
    setState(() {
      if (likeId != 0) {
        isLike = true;
      } else {
        isLike = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetStatus();
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
        body: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.author.avatar as String),
                radius: 30,
              ),
              title: Text(
                widget.author.name as String,
                style: const TextStyle(fontFamily: "gengsha", fontSize: 20),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListTile(
                title: Text(
                  "标题:",
                  style: TextStyle(fontFamily: "gengsha", fontSize: 20),
                ),
                subtitle: Text(
                  widget.author.title as String,
                  style: TextStyle(fontFamily: "gengsha", fontSize: 40),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListTile(
                      title: Text(
                        "内容:",
                        style: TextStyle(fontFamily: "gengsha", fontSize: 20),
                      ),
                      subtitle: Text(
                        widget.author.content as String,
                        style: TextStyle(fontFamily: "gengsha", fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: IconButton(
                        onPressed: () async {
                          if (isLike) {
                            await deleteLikeStatus(
                                context: context, id: likeId);
                            setState(() {
                              isLike = false;
                            });
                          } else {
                            await putLikeStatus(
                                context: context,
                                params: LikeStatusRequest(
                                    id: widget.author.id,
                                    userName: Global.profile?.displayName));
                          }
                          fetStatus();
                          setState(() {
                            isLike = true;
                          });
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          size: 25.0,
                          color: isLike ? Colors.yellow[600] : Colors.grey,
                        )),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
