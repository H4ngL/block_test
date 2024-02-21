import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/programming_blocks/a_block.dart';
import 'ui/programming_blocks/block_by_shape.dart';
import 'ui/programming_blocks/manager/linkedlist.dart';
import 'ui/programming_blocks/manager/ll.dart';
import 'ui/programming_blocks/manager/ll_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LLManager()),
        ChangeNotifierProvider(create: (context) => LinkedList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> children = [];
  final LinkedList2 linkedList = LinkedList2();
  @override
  Widget build(BuildContext context) {
    Node2? node = linkedList.head;
    children.clear();
    while (node != null) {
      children.add(node.widget!);
      node = node.next;
    }
    debugPrint("children : ${children.toString()}");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Block test'),
        ),
        body: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 150,
                  left: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              ],
            );
          },
          onWillAccept: (data) {
            debugPrint("onWillAccept");
            // Provider.of<LinkedList>(context, listen: false).shrinkTP();
            return true;
          },
          onLeave: (data) {
            debugPrint("onLeave");
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                // Provider.of<LinkedList>(context, listen: false).add(
                //   TPBlock(height: 0),
                // );
                // Provider.of<LinkedList>(context, listen: false).add(
                //   const BlockByShape(
                //     shape: ProgrammingBlockShape.simple,
                //     color: Colors.blue,
                //     content: 'Simple block Simple block',
                //   ),
                // );
                // children.add(TPBlock(height: 0));
                // var node = Node2(prev: linkedList.tail);
                var node = linkedList.add();
                var block = ABlock(
                  blockShape: const BlockByShape(
                    shape: ProgrammingBlockShape.simple,
                    color: Colors.blue,
                    content: 'Simple block Simple block',
                  ),
                  node: node,
                );
                // Provider.of<LinkedList>(context, listen: false).add(
                //   const BlockByShape(
                //     shape: ProgrammingBlockShape.simple,
                //     color: Colors.blue,
                //     content: 'Simple block Simple block',
                //   ),
                // );
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                // Provider.of<LinkedList>(context, listen: false).add(
                //   TPBlock(height: 0),
                // );
                // Provider.of<LinkedList>(context, listen: false).add(
                //   const BlockByShape(
                //     shape: ProgrammingBlockShape.withReturn,
                //     color: Colors.red,
                //     content: 'Return block',
                //   ),
                // );
                var node = linkedList.add();
                var block = ABlock(
                  blockShape: const BlockByShape(
                    shape: ProgrammingBlockShape.simple,
                    color: Colors.red,
                    content: 'Simple block Simple block',
                  ),
                  node: node,
                );
                setState(() {});
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                // Provider.of<LinkedList>(context, listen: false).clear();
                children.clear();
                setState(() {});
              },
              child: const Icon(
                Icons.clear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
