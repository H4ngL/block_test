import 'package:block_test/programming_blocks.dart';
import 'package:flutter/material.dart';

class Node {
  Node? next;
  Node? prev;
  Widget? widget;
  Node({this.next, this.prev, this.widget});
}

const plus = 4;

class LinkedList with ChangeNotifier {
  Node? head;
  Node? tail;
  int length = 0;

  int get size => length;

  void add(Widget widget) {
    Node node = Node(widget: widget);
    if (head == null) {
      head = node;
      tail = node;
    } else {
      tail!.next = node;
      node.prev = tail;
      tail = node;
    }
    length++;

    notifyListeners();
  }

  void removeLast() {
    if (tail == null) {
      return;
    }
    if (tail!.prev == null) {
      head = null;
      tail = null;
    } else {
      tail = tail!.prev;
      tail!.next = null;
    }
    length--;
    notifyListeners();
  }

  void removeFirst() {
    if (head == null) {
      return;
    }
    if (head!.next == null) {
      head = null;
      tail = null;
    } else {
      head = head!.next;
      head!.prev = null;
    }
    length--;
    notifyListeners();
  }

  void remove(Node node) {
    if (node.prev == null) {
      removeFirst();
    } else if (node.next == null) {
      removeLast();
    } else {
      node.prev!.next = node.next;
      node.next!.prev = node.prev;
      length--;
    }
    notifyListeners();
  }

  void cut(Node node) {
    Node prev = node.prev!;

    if (prev.prev == null) {
      head = null;
      tail = null;
    } else if (prev.next == null) {
      tail = prev.prev;
      tail!.next = null;
    } else {
      prev.prev!.next = null;
      tail = prev.prev;
    }
    length -= lengthFromNode(prev);
    notifyListeners();
  }

  int lengthFromNode(Node node) {
    int count = 0;
    while (node.next != null) {
      count++;
      node = node.next!;
    }
    return count + 1;
  }

  void insertAfter(Node? node, Widget widget) {
    Node newNode = Node(widget: widget);
    if (node!.next == null) {
      tail = newNode;
    } else {
      node.next!.prev = newNode;
      newNode.next = node.next;
    }
    node.next = newNode;
    newNode.prev = node;
    length++;
    notifyListeners();
  }

  void insertBefore(Node node, Widget widget) {
    Node newNode = Node(widget: widget);
    if (node.prev == null) {
      head = newNode;
    } else {
      node.prev!.next = newNode;
      newNode.prev = node.prev;
    }
    node.prev = newNode;
    newNode.next = node;
    length++;
    notifyListeners();
  }

  List<Widget> toList() {
    List<Widget> list = [];
    Node? node = head;
    while (node != null) {
      list.add(node.widget!);
      node = node.next;
    }
    return list;
  }

  void shrinkTP() {
    Node? node = head;
    while (node != null) {
      if (node.widget is TPBlock) {
        TPBlock tpBlock = node.widget as TPBlock;
        if (tpBlock.height == 36.0 + plus) {
          node.widget = TPBlock(height: 0.0);
        }
      }
      node = node.next;
      notifyListeners();
    }
  }

  void increaseHeight(Node node, String content) {
    Node prev = node.prev!;
    TPBlock tpBlock = prev.widget as TPBlock;

    if (tpBlock.height == 0.0) {
      shrinkTP();

      prev.widget = TPBlock(
        height: 36.0 + plus,
        color: Colors.grey[600],
        content: content,
        isPadding: true,
      );
      notifyListeners();
    }
  }

  List<Widget> toDraggable() {
    List<Widget> list = [];
    Node? node = head;

    while (node != null) {
      Node capturedNode = node;

      if (capturedNode.widget is TPBlock) {
        list.add(
          DragTarget<List>(
            builder: (context, candidateData, rejectedData) {
              return capturedNode.widget!;
            },
            onLeave: (data) {
              capturedNode.widget = TPBlock(height: 0.00);
            },
            onAccept: (data) {
              capturedNode.widget = TPBlock(height: 0.0);

              Node current = capturedNode;

              for (Widget widget in data) {
                if (widget is BlockByShape) {
                  insertAfter(current, widget);
                  insertAfter(current.next, TPBlock(height: 0.0));
                  current = current.next!.next!;
                }
              }
            },
          ),
        );
        node = node.next;
      } else {
        BlockByShape blockByShape = capturedNode.widget as BlockByShape;
        list.add(
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: blockByShape.color,
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            child: DragTarget<List>(
              builder: (context, candidateData, rejectedData) {
                return LongPressDraggable(
                  delay: const Duration(milliseconds: 10),
                  feedback: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [...toListFromNode(capturedNode)],
                  ),
                  childWhenDragging: Container(),
                  data: toListFromNode(capturedNode),
                  onDragStarted: () {
                    cut(capturedNode);
                  },
                  child: capturedNode.widget!,
                );
              },
              onWillAccept: (data) {
                // print("onWillAccept");
                List<Widget> list = data as List<Widget>;
                BlockByShape node = list[0] as BlockByShape;
                increaseHeight(capturedNode, node.content);
                return true;
              },
              onAccept: (data) {
                // for (Widget widget in data) {
                //   if (capturedNode.prev != null) {
                //     insertAfter(capturedNode.prev, widget);
                //   } else {
                //     insertBefore(capturedNode, widget);
                //   }
                // }
              },
            ),
          ),
        );
        node = node.next;
      }
    }
    return list;
  }

  Widget toDraggableList() {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        return LongPressDraggable(
          delay: const Duration(milliseconds: 10),
          feedback: toList()[index],
          childWhenDragging: Container(),
          child: toList()[index],
        );
      },
    );
  }

  List<Widget> toListFromNode(Node node) {
    List<Widget> list = [];
    while (node.next != null) {
      list.add(node.widget!);
      node = node.next!;
    }
    list.add(node.widget!);
    return list;
  }

  void clear() {
    head = null;
    tail = null;
    length = 0;
    notifyListeners();
  }
}

class TPBlock extends StatefulWidget {
  var height = 0.0;
  var color;
  var content;

  final bool isPadding;

  TPBlock({
    Key? key,
    required this.height,
    this.color,
    this.content,
    bool? isPadding,
  })  : isPadding = isPadding ?? false,
        super(key: key);

  @override
  State<TPBlock> createState() => _TPBLockState();
}

class _TPBLockState extends State<TPBlock> {
  @override
  Widget build(BuildContext context) {
    debugPrint("TPBlock build");

    return Container(
      // padding: EdgeInsets.symmetric(
      //   horizontal: widget.isPadding ? 7.0 : 0.0,
      //   vertical: widget.isPadding ? 10.0 : 0.0,
      // ),
      height: widget.height,
      width: 250,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      // child: DefaultTextStyle(
      //   style: TextStyle(color: widget.color ?? Colors.transparent),
      //   child: Text(widget.content ?? ""),
      // ),
    );

    // onLeave: (data) {
    //   print("onLeave");
    //   setState(() {
    //     widget.height = 0.01;
    //     widget.content = "";
    //   });
    // },
    // onAccept: (data) {
    //   print("onAccept");
    //   setState(() {
    //     widget.height = 0.0;
    //     widget.content = "";
    //   });
    // },
  }
}
