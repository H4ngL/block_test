import 'package:block_test/programming_blocks.dart';
import 'package:flutter/material.dart';

import 'manager/linkedlist.dart';

class ABlock extends StatefulWidget {
  final BlockByShape blockShape;
  final Node2 node;

  ABlock({
    super.key,
    required this.blockShape,
    required this.node,
  }) {
    node.widget = this;
  }

  @override
  State<ABlock> createState() => _ABLockState();
}

class _ABLockState extends State<ABlock> {
  List<Widget>? feedback;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> getWidgets() {
    List<Widget> list = [];
    Node2? node = widget.node;
    while (node != null) {
      list.add(node.widget!);
      node = node.next;
    }
    debugPrint(list.toString());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ABlock build");

    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          var sss = getWidgets();
          debugPrint(sss.toString());
          return Draggable(
            // delay: const Duration(milliseconds: 10),
            feedback: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: feedback ?? [], //List.from(widget.children),
            ),
            // feedback: widget,
            // data: toListFromNode(widget.capturedNode),
            onDragStarted: () {
              // cut(widget.capturedNode);
              feedback = getWidgets();
              widget.node.prev?.next = null;
              widget.node.prev = null;
              setState(() {});
            },
            child: widget.blockShape,
          );
        },
        onWillAccept: (data) {
          // print("onWillAccept");
          if (data == null) return false;
          List<Widget> list = data as List<Widget>;
          BlockByShape node = list[0] as BlockByShape;
          // increaseHeight(widget.capturedNode, node.content);
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
    );
  }
}
