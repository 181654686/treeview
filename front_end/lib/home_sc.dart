import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInside = false;
  PointerEvent _lastEvent;

  @override
  Widget build(BuildContext context) {
    final String formattedEvent = _lastEvent?.toString()?.replaceAllMapped(
          RegExp(
            ', ([a-z])',
          ),
          (match) => ',\n${match[1]}',
        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Mouse Events'),
      ),
      body: SafeArea(
        child: Center(
          child: MouseRegion(
            onEnter: (PointerEnterEvent event) {
              setState(() {
                _isInside = true;
                _lastEvent = event;
              });
            },
            onHover: (PointerHoverEvent event) {
              setState(() {
                _lastEvent = event;
              });
            },
            onExit: (PointerExitEvent event) {
              setState(() {
                _isInside = false;
                _lastEvent = event;
              });
            },
            child: Listener(
              onPointerSignal: (PointerSignalEvent event) {
                if (event is PointerScrollEvent) {
                  setState(() {
                    _lastEvent = event;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(
                  12.0,
                ),
                width: 300.0,
                height: 600.0,
                color:
                    _isInside ? Colors.lightGreen[200] : Colors.lightBlue[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _isInside ? 'In' : 'Out',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      'Last Event: $formattedEvent',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                      icon: Icon(Icons.ac_unit),
                      iconSize: 50,
                      onPressed: () {
                        print('object');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
