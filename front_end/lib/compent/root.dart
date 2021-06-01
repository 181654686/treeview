import 'package:flutter/material.dart';

class RootItemWidget extends StatefulWidget {
  final RootItemModel itemModel;
  @override
  _RootItemState createState() => _RootItemState();
  RootItemWidget({Key key, this.itemModel});
}

enum itemMode { select, edit, view, hover }

class _RootItemState extends State<RootItemWidget> {
  var mode = itemMode.view;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print('--tap--');
          mode = itemMode.select;
          setState(() {});
        },
        onDoubleTap: () {
          mode = itemMode.edit;
          setState(() {});
        },
        onHover: (value) {
          print("hover" + mode.toString());
          if (mode == itemMode.view) {
            mode = itemMode.hover;
            setState(() {});
          } else if (mode == itemMode.hover) {
            mode = value ? itemMode.hover : itemMode.view;
            setState(() {});
          }
        },
        child: Container(
            width: 200,
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
              border: (mode != itemMode.view)
                  ? new Border.all(width: 2.0, color: Colors.blue[100])
                  : null,
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            ),
            child: Container(
              width: 196,
              height: 56,
              decoration: new BoxDecoration(color: Colors.blue),
              child: mode == itemMode.edit
                  ? TextField(
                      showCursor: true,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        mode = itemMode.view;
                        print('!!');
                        setState(() {});
                      },
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    )
                  : Text("中心主题",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 32)),
            )));
  }
}

// 控件数据实体类
class RootItemModel {
  String content;
  String type;
  RootItemModel({this.content, this.type});
}
