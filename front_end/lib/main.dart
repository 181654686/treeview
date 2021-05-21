import 'package:flutter/material.dart';
import 'groupWidgt.dart';
import 'pie.dart';
import 'dart:html';
import 'draw_screen.dart';
import 'compent/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var gp = GroupViewWidget(
      itemModel: ItemModel(
          icon: '', rank: '1', name: '简书', description: '创造你的创造', type: '文学创造'),
      onPressed: () {},
    );
    var pie = WheelWidget();
    var item = RootItemModel(content: "root");
    var root = RootItemWidget(
      itemModel: item,
    );
    var sta = new Stack(
      children: [
        Positioned(child: gp, left: 100, top: 100),
        Positioned(child: pie, left: 200, top: 200),
        Positioned(child: root, left: 400, top: 400)
      ],
    );

    return Scaffold(
      body: sta,
    );
  }
}
