import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treeview/select_rect.dart';
import 'dart:html';

import 'compent/root.dart';
import 'main_menu.dart';

void main() async {
  // 鼠标右键
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  window.document.onMouseWheel.listen((event) {
    if (event.ctrlKey == true) {
      print(event);
      print('control +++++++++++');
      event.preventDefault();
      return true;
    }
  });
  window.onKeyDown.listen((event) {
    if (event.ctrlKey == true &&
        (event.keyCode == 61 ||
            event.keyCode == 107 ||
            event.keyCode == 173 ||
            event.keyCode == 109 ||
            event.keyCode == 187 ||
            event.keyCode == 189)) {
      event.preventDefault();
    }
  });
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcut Test',
      theme: ThemeData(
        fontFamily: 'NotoSansSC',
        primarySwatch: Colors.blueGrey,
      ),
      home: ShortcutTest(),
    );
  }
}

enum mode_status { view, edit, select, menu }
enum menu_status { none, main }

class ShortcutTest extends StatefulWidget {
  @override
  _ShortcutTestState createState() => _ShortcutTestState();
}

class _ShortcutTestState extends State<ShortcutTest> {
  InteractionManager interactionManager = InteractionManager();

  @override
  void initState() {
    super.initState();
    _rootNode.requestFocus();
  }

  double _left_dx = 0.0;
  double _left_dy = 0.0;

  double start_dx = 0.0;
  double start_dy = 0.0;
  double end_dx = 0.0;
  double end_dy = 0.0;

  double _dx = 0.0;
  double _dy = 0.0;
  double _scale = 2.0;
  String _key = '';
  menu_status _menu = menu_status.none;
  var _mode = mode_status.view;
  TextEditingController _controller = new TextEditingController();
  FocusNode _rootNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double _previousScale;

    return RawKeyboardListener(
      autofocus: false,
      focusNode: _rootNode,
      onKey: (event) {
        print('Key Pressed: ${event.logicalKey.keyLabel}');
        if (event.runtimeType == RawKeyDownEvent) {
          interactionManager.addKeyPressed(event.logicalKey);
          _key = event.logicalKey.keyLabel;
        } else if (event.runtimeType == RawKeyUpEvent) {
          interactionManager.removeKeyPressed(event.logicalKey);
          _key = '';
        }

        // setState(() {});
        // return null;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 244, 247),
        body: Stack(
          children: [
            Listener(
              onPointerDown: (event) {
                print('onPointerDown');
                FocusScope.of(context).requestFocus(_rootNode);
                print(event.buttons);
                if (event.buttons == 1) {
                  _mode = mode_status.select;
                  start_dx = event.position.dx;
                  start_dy = event.position.dy;
                  end_dx = event.position.dx - start_dx;
                  end_dy = event.position.dy - start_dy;
                  setState(() {});
                } else {
                  print('----');
                  _mode = mode_status.menu;
                  _menu = menu_status.main;
                  _left_dx = event.position.dx;
                  _left_dy = event.position.dy;
                  setState(() {});
                }
              },
              onPointerMove: (event) {
                if (_mode == mode_status.select) {
                  end_dx = event.position.dx - start_dx;
                  end_dy = event.position.dy - start_dy;
                  setState(() {});
                }
                print('onPointerMove');
              },
              onPointerUp: (event) {
                print('onPointerUp');
                if (_mode == mode_status.menu) return;
                _mode = mode_status.view;
                setState(() {});
              },
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  // print('x: ${event.position.dx}, y: ${event.position.dy}');
                  // print('scroll delta: ${event.scrollDelta.dy}');

                  setState(() {
                    if (_key == '') {
                      _dy = _dy + event.scrollDelta.dy / 5;
                      print(_dy);
                    }
                    if (_key.toLowerCase() == 'control left') {
                      if (event.scrollDelta.dy < 0) {
                        _scale = _scale * 1.1;
                        print(_scale);
                      } else {
                        _scale = _scale / 1.1;
                        print(_scale);
                      }
                    }
                  });
                }
              },
              onPointerHover: (event) => {print('onPointerHover')},
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: Container(),
              ),
            ),
            Positioned(
                left: _left_dx,
                top: _left_dy,
                child: Visibility(
                  visible: _mode == mode_status.menu,
                  child: mymenu(),
                )),
            Positioned(
                left: start_dx,
                top: start_dy,
                child: Visibility(
                    visible: _mode == mode_status.select,
                    child: select_rect(
                        size: Size(double.maxFinite, double.maxFinite),
                        dx: end_dx,
                        dy: end_dy))),
            Positioned(
              child: Transform(
                  transform: Matrix4.identity()
                    ..translate(_dx, _dy)
                    ..scale(_scale, _scale),
                  child: buildRoot()),
              left: 400,
              top: 400,
            ),
            // Center(
            //     child: Transform(
            //         transform: Matrix4.identity()
            //           ..translate(_dx, _dy)
            //           ..scale(_scale, _scale),
            //         child: Container(
            //           child: EditableText(
            //             focusNode: FocusNode()..requestFocus(),
            //             backgroundCursorColor: Colors.transparent,
            //             controller: _controller,
            //             cursorColor: Colors.black,
            //             style: TextStyle(fontSize: 20),
            //           ),
            //         ))),
          ],
        ),
      ),
    );
  }

  Widget buildRoot() {
    var item = RootItemModel(content: "root");
    var root = RootItemWidget(
      itemModel: item,
    );
    return root;
  }

  String printKeysPressed(Set<LogicalKeyboardKey> keys) {
    if (keys.length == 0) return 'No keys pressed.';
    return keys.map((e) => e.debugName).join(', ');
  }
}

class InteractionManager {
  Set<LogicalKeyboardKey> _keyPressed = Set();
  Set<LogicalKeyboardKey> get keyPressed => _keyPressed;

  void addKeyPressed(LogicalKeyboardKey key) {
    _keyPressed.add(key);
  }

  void removeKeyPressed(LogicalKeyboardKey key) {
    _keyPressed.remove(key);
  }
}
