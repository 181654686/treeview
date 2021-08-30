import 'dart:collection';

import '../compent/root.dart';
import '../compent/link.dart';

class Node<T> {
  int depth;
  int index;
  int nodeId;
  int x;
  int y;
  T object;

  Node parent;
  List<Node> children;
  bool expand;
  List<link> links;
  RootItemWidget rootwidget;
  Node(this.depth, this.index, this.nodeId, this.x, this.y, this.expand,
      this.object);
}

class link {
  Node parent;
  Node child;
  linkWidget linkwidget;
  link(this.parent, this.child, this.linkwidget);
}

class TreeNode {
  var data;
  TreeNode(this.data);

  List<Node> tree2node() {
    List<Node> nodelist = new List();
    int depth = 0;
    Node parent;

    Queue temp = new Queue();
    temp.add(data);
    while (temp.length > 0) {
      var tempData = temp.removeFirst();
      Node n = new Node(depth, tempData['index'], tempData['key'], 0, 0,
          tempData['expand'], tempData['data']);
      nodelist.add(n);
      // if ((tempData['children']) > 0) {}
    }
    return nodelist;
  }
}
