# treeview
a tool for tree view



# demo
https://whimsical.com/bwo-CkYzWZKNNz5is2GY4Y2yDY



# 放大
https://blog.csdn.net/u014165119/article/details/100986742



# widget 位置
https://blog.csdn.net/lmh_19941113/article/details/101162621




# key.dart

~~~
  // 鼠标右键 阻止浏览器
  window.document.onContextMenu.listen((evt) => evt.preventDefault());

~~~

~~~
//鼠标 wheel+contrl 没有效果
window.document.onMouseWheel.listen((event) {
    if (event.ctrlKey == true) {
      print(event);
      print('control +++++++++++');
      event.preventDefault();
      return true;
    }
  });

    //html中 
    document.addEventListener('wheel', function(e) {
    e.ctrlKey && e.preventDefault();
    }, {
      passive: false,
    });
~~~

记录按键事件
~~~
RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: (event) {
        print('Key Pressed: ${event.logicalKey.keyLabel}');
        if (event.runtimeType == RawKeyDownEvent) {
          interactionManager.addKeyPressed(event.logicalKey);
          _key = event.logicalKey.keyLabel;
        } else if (event.runtimeType == RawKeyUpEvent) {
          interactionManager.removeKeyPressed(event.logicalKey);
          _key = '';
        }

        setState(() {});
        return null;
      },


//这个类记录按键的按下和弹起。 例如CTRL+V，conrl+C
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

~~~






鼠标事件

~~~
 Listener(
              onPointerDown: (event) {
                print('onPointerDown');
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

~~~


平移，放大功能
~~~
Transform(
                    transform: Matrix4.identity()
                      ..translate(_dx, _dy)
                      ..scale(_scale, _scale),
                    child: Container(

~~~


右键菜单
~~~
            Positioned(
                left: _left_dx,
                top: _left_dy,
                child: Visibility(
                  visible: _mode == mode_status.menu,
                  child: mymenu(),
                )),
~~~


选择框
~~~
            Positioned(
                left: start_dx,
                top: start_dy,
                child: Visibility(
                    visible: _mode == mode_status.select,
                    child: select_rect(
                        size: Size(double.maxFinite, double.maxFinite),
                        dx: end_dx,
                        dy: end_dy))),
~~~

focusNode
~~~
 focusNode: _itemnode,
FocusScope.of(context).requestFocus(_rootNode);
~~~


# flutter 通信
https://www.jianshu.com/p/e201f6b764f8
1，callback

2，event bus

3,flutter-redux
https://www.jianshu.com/p/216e340ac63a?utm_campaign=maleskine



# float_menu
https://github.com/akshayejh/floating_panel/blob/master/lib/floatingpanel.dart

widget flex(column,row)

# widget 大小
https://blog.csdn.net/studying_ios/article/details/108870555


# 复制
https://pub.flutter-io.cn/packages/clipboard
clipboard

