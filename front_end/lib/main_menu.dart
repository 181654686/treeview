import 'package:flutter/material.dart';

class ItemModel {
  String title;
  IconData icon;
  ItemModel(this.title, this.icon);
}

// class NavDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<ItemModel> menuItems = [
//       ItemModel('发起群聊', Icons.chat_bubble),
//       ItemModel('添加朋友', Icons.group_add),
//       ItemModel('扫一扫', Icons.settings_overscan),
//     ];

//     return Container(
//       color: const Color(0xFF4C4C4C),
//       padding: EdgeInsets.all(10),
//       child: Column(children: menuItems.map((e) => buildItem(e)).toList()),
//     );
//   }
// }

Widget buildItem(ItemModel item) {
  var isHover;
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          item.icon,
          size: 20,
          color: Colors.white,
        ),
        Container(
          margin: EdgeInsets.only(left: 2),
          child: Text(
            item.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

class mymenu extends StatefulWidget {
  final List<ItemModel> menuItems;
  const mymenu({this.menuItems});

  @override
  _mymenuState createState() => _mymenuState();
}

class _mymenuState extends State<mymenu> {
  @override
  Widget build(BuildContext context) {
    List<ItemModel> menuItems = [
      ItemModel('发起群聊', Icons.chat_bubble),
      ItemModel('添加朋友', Icons.group_add),
      ItemModel('扫一扫', Icons.settings_overscan),
    ];
    return Container(
      color: const Color(0xFF4C4C4C),
      padding: EdgeInsets.all(10),
      child: Column(
          children: menuItems
              .map((e) => InkWell(
                    onHover: (value) {
                      setState(() {});
                    },
                    child: buildItem(e),
                  ))
              .toList()),
    );
    ;
  }
}
