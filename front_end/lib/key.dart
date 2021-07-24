import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcut Test',
      home: ShortcutTest(),
    );
  }
}

class ShortcutTest extends StatefulWidget {
  @override
  _ShortcutTestState createState() => _ShortcutTestState();
}

class _ShortcutTestState extends State<ShortcutTest> {
  InteractionManager interactionManager = InteractionManager();

  @override
  void initState() {
    super.initState();
  }

  double _dx = 0.0;
  double _dy = 0.0;
  double _scale = 2.0;
  String _key = '';
  @override
  Widget build(BuildContext context) {
    double _previousScale;

    return RawKeyboardListener(
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
      child: Scaffold(
        body: Stack(
          children: [
            Listener(
              onPointerDown: (event) => {print('onPointerDown')},
              onPointerMove: (event) => {print('onPointerMove')},
              onPointerUp: (event) => {print('onPointerUp')},
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
            Center(
                child: Transform(
                    transform: Matrix4.identity()
                      ..translate(_dx, _dy)
                      ..scale(_scale, _scale),
                    child: Container(
                      child: Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                    ))),
          ],
        ),
      ),
    );
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
