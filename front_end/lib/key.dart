import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: (event) {
        print('Key Pressed: ${event.logicalKey}');
        if (event.runtimeType == RawKeyDownEvent) {
          interactionManager.addKeyPressed(event.logicalKey);
        } else if (event.runtimeType == RawKeyUpEvent) {
          interactionManager.removeKeyPressed(event.logicalKey);
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
              onPointerSignal: (event) => {print('onPointerSignal')},
              onPointerHover: (event) => {print('onPointerHover')},
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: Container(),
              ),
            ),
            Center(
              child: Text(printKeysPressed(interactionManager.keyPressed),
                  style: TextStyle(fontSize: 24, color: Colors.black)),
            ),
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
