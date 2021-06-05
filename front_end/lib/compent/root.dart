import 'package:flutter/material.dart';

class RootItemWidget extends StatefulWidget {
  final RootItemModel itemModel;
  @override
  _RootItemState createState() => _RootItemState();
  RootItemWidget({Key key, this.itemModel});
}

enum itemMode { select, edit, view, hover }

class _RootItemState extends State<RootItemWidget> {
  var _mode = itemMode.view;
  var _txtControl;

  @override
  Widget build(BuildContext context) {
    _txtControl = TextEditingController(text: widget.itemModel.content);
    return InkWell(
        onTap: () {
          print('--tap--');
          _mode = itemMode.select;
          setState(() {});
        },
        onDoubleTap: () {
          _mode = itemMode.edit;
          setState(() {});
        },
        onHover: (value) {
          print("hover" + _mode.toString());
          if (_mode == itemMode.view) {
            _mode = itemMode.hover;
            setState(() {});
          } else if (_mode == itemMode.hover) {
            _mode = value ? itemMode.hover : itemMode.view;
            setState(() {});
          }
        },
        child: Container(
            width: 200,
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
              border: (_mode != itemMode.view)
                  ? new Border.all(width: 2.0, color: Colors.blue[100])
                  : null,
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            ),
            child: Container(
              width: 196,
              height: 56,
              decoration: new BoxDecoration(color: Colors.blue),
              child: _mode == itemMode.edit
                  ? TextField(
                      showCursor: true,
                      cursorColor: Colors.white,
                      cursorWidth: 3,
                      autofocus: true,
                      controller: _txtControl,
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        _mode = itemMode.view;
                        widget.itemModel.content = value;
                        print(widget.itemModel.content);
                        setState(() {});
                      },
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    )
                  : Text(widget.itemModel.content,
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
