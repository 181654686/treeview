import 'package:flutter/material.dart';
import 'root_lint.dart';

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
  GlobalKey _keyInk = GlobalKey();

  // Size _getSize() {
  //   // final RenderBox renderBox = ;
  //   // globalKey.currentContext.size

  //   final sizeGreen = _keyInk.currentContext.size;
  //   print("SIZE of green: $sizeGreen");
  //   return sizeGreen;
  // }

  @override
  Widget build(BuildContext context) {
    _txtControl = TextEditingController(text: widget.itemModel.content);
    var _ink = InkWell(
        key: _keyInk,
        onTap: () {
          print('--tap--');
          if (_mode == itemMode.view) {
            _mode = itemMode.select;
            setState(() {});
          }
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
            // width: _width + 4,
            // height: _height + 4,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
              border: (_mode != itemMode.view)
                  ? new Border.all(width: 2.0, color: Colors.blue[100])
                  : new Border.all(width: 2.0, color: Colors.transparent),
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            ),
            child: Container(
                padding: EdgeInsets.all(2.0),
                constraints: BoxConstraints(
                  maxHeight: 200.0,
                  minHeight: 50.0,
                  minWidth: 100.0,
                  maxWidth: 300.0,
                ),
                decoration: new BoxDecoration(
                    border: new Border.all(
                      width: 2.0,
                      color: Colors.black,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                    color: Colors.grey[200]),
                child: IntrinsicWidth(
                    stepWidth: 60,
                    child: TextField(
                      showCursor: true,
                      cursorColor: Colors.white,
                      cursorWidth: 3,
                      // cursorHeight: 24,
                      autofocus: true,
                      enabled: _mode == itemMode.edit,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      onEditingComplete: () {
                        print('onEditingComplete');
                      },
                      onChanged: (value) {},
                      controller: _txtControl,
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        _mode = itemMode.view;
                        widget.itemModel.content = value;
                        print(widget.itemModel.content);
                        setState(() {});
                      },
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )))));

    var _btn = Container(
      width: 30.0,
      height: 30.0,
      decoration: new BoxDecoration(
        border: new Border.all(width: 2.0, color: Colors.black),
        borderRadius: new BorderRadius.all(new Radius.circular(15)),
      ),
      child: Center(
          child:
              Text('3', style: TextStyle(color: Colors.black, fontSize: 15))),
    );

    var _rootLine = RootLineWidget();

    var _stack = Row(
      children: [
        _ink,
        _rootLine,
        _btn,
      ],
    );
    return _stack;
  }
}

// 控件数据实体类
class RootItemModel {
  String content;
  String type;
  int sonNumber; //number of sons
  int status; //open,close
  RootItemModel({this.content, this.type, this.sonNumber, this.status});
}
