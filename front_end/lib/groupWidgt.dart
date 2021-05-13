import 'package:flutter/material.dart';

// 组合控件
class GroupViewWidget extends StatelessWidget {
  final ItemModel itemModel;
  final VoidCallback onPressed;

  GroupViewWidget({Key key, this.itemModel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hitme');
      },
      onSecondaryTap: () {
        print('ri me');
      },
      child: Column(
        children: <Widget>[
          // Padding 控件，用来设置 Image 控件内边距
          Padding(
            // 上下左右边距均为 10
            padding: EdgeInsets.all(10),
            // 圆角矩形裁剪控件
            child: ClipRRect(
              // 圆角半径为 8
              borderRadius: BorderRadius.circular(8.0),
              // 图片控件
              child: Icon(Icons.favorite),
            ),
          ),
          Text('good')
        ],
      ),
    );
  }
}

// 控件数据实体类
class ItemModel {
  String icon;
  String rank;
  String name;
  String type;
  String description;

  ItemModel({this.icon, this.rank, this.name, this.type, this.description});
}
