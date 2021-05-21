import 'package:flutter/material.dart';

class RootItemWidget extends StatefulWidget {
  final RootItemModel itemModel;
  @override
  _RootItemState createState() => _RootItemState();
  RootItemWidget({Key key, this.itemModel});
}

class _RootItemState extends State<RootItemWidget> {
  var mode = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          mode = !mode;
          setState(() {});
        },
        child: Container(
          width: 200,
          height: 30,
          decoration: new BoxDecoration(
            border: new Border.all(width: 2.0, color: Colors.red),
            color: Colors.grey,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          ),
          child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
              ),
              onSubmitted: (text) {
                //内容提交(按回车)的回调
                print('submit $text');
                mode = !mode;
                setState(() {});
              },
              style: TextStyle(fontSize: 30.0, color: Colors.black),
              enabled: mode),
        ));
  }
}

// 控件数据实体类
class RootItemModel {
  String content;
  String type;
  RootItemModel({this.content, this.type});
}
