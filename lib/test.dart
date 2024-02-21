// import 'package:flutter/material.dart';

// const appBarHeight = 56.0;
// const blockHeight = 50.0;
// const blockWidth = 150.0;

// var p2 = const ChildBlock(
//   position: Offset(100, 100 + blockHeight),
//   innerBlock: InnerBlock(
//     color: Colors.blue,
//   ),
// );

// var p1 = OutterBlock(
//     position: const Offset(100, 100),
//     innerBlock: const InnerBlock(color: Colors.red),
//     child: p2);

// List<Widget> blocks = [p1, p2];

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> b = blocks;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Block test'),
//         ),
//         body: Stack(children: [
//           ...b,
//         ]),
//       ),
//     );
//   }
// }

// class BlockChunk extends StatefulWidget {
//   const BlockChunk({super.key});

//   @override
//   BlockChunkState createState() => BlockChunkState();
// }

// class BlockChunkState extends State<BlockChunk> {
//   final Offset _position = const Offset(100.0, 100.0);

//   @override
//   Widget build(BuildContext context) {
//     // var p2 = ChildBlock(
//     //   position: Offset(_position.dx, _position.dy + blockHeight),
//     //   innerBlock: const InnerBlock(
//     //     color: Colors.blue,
//     //   ),
//     // );

//     // var p1 = OutterBlock(
//     //     position: _position,
//     //     innerBlock: const InnerBlock(color: Colors.red),
//     //     child: p2);

//     // var p1 = Positioned(
//     //   left: _position.dx,
//     //   top: _position.dy - appBarHeight,
//     //   child: Draggable(
//     //     feedback: Container(
//     //       width: blockWidth,
//     //       height: blockHeight,
//     //       color: Colors.blue,
//     //       child: Center(
//     //         child: Column(
//     //           children: [
//     //             Container(
//     //                 width: blockWidth, height: blockHeight, color: Colors.blue),
//     //             Container(
//     //                 width: blockWidth, height: blockHeight, color: Colors.red),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //     onDraggableCanceled: (velocity, offset) {
//     //       onCancle(offset, velocity);
//     //     },
//     //     childWhenDragging: Container(),
//     //     child: Container(
//     //       width: blockWidth,
//     //       height: blockHeight,
//     //       color: Colors.blue,
//     //       child: const Center(
//     //         child: Text(
//     //           '드래그',
//     //           style: TextStyle(
//     //             color: Colors.black,
//     //             fontSize: 20,
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//     // var p2 = Positioned(
//     //   left: _position.dx,
//     //   top: (_position.dy - appBarHeight) + blockHeight,
//     //   child: Draggable(
//     //     feedback: Container(
//     //       width: blockWidth,
//     //       height: blockHeight,
//     //       color: Colors.red,
//     //       child: const Center(
//     //         child: DefaultTextStyle(
//     //           style: TextStyle(
//     //             color: Colors.black,
//     //             fontSize: 20,
//     //           ),
//     //           child: Text("드래그 중"),
//     //         ),
//     //       ),
//     //     ),
//     //     childWhenDragging: Container(),
//     //     child: Container(
//     //       width: blockWidth,
//     //       height: blockHeight,
//     //       color: Colors.red,
//     //       child: const Center(
//     //         child: Text(
//     //           '드래그',
//     //           style: TextStyle(
//     //             color: Colors.black,
//     //             fontSize: 20,
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //     onDraggableCanceled: (velocity, offset) {
//     //       double newX = offset.dx
//     //           .clamp(0.0, MediaQuery.of(context).size.width - blockWidth);
//     //       double newY = offset.dy.clamp(appBarHeight,
//     //               MediaQuery.of(context).size.height - blockHeight) -
//     //           blockHeight;
//     //       setState(() {
//     //         _position = Offset(newX, newY);
//     //       });
//     //     },
//     //   ),
//     // );

//     return Stack(
//       children: blocks,
//     );
//   }
// }

// class OutterBlock extends StatefulWidget {
//   final Offset position;
//   final InnerBlock innerBlock;
//   final ChildBlock? child;

//   const OutterBlock({
//     Key? key,
//     required this.position,
//     required this.innerBlock,
//     this.child,
//   }) : super(key: key);

//   @override
//   State<OutterBlock> createState() => _OutterBlockState();
// }

// class _OutterBlockState extends State<OutterBlock> {
//   Offset position = const Offset(100.0, 100.0);
//   ChildBlock? child;
//   Widget innerBlock = Container();
//   var feedback = const Column();
//   bool flag = false;
//   onCancle(offset, velocity) {
//     // double newX = offset.dx
//     //     .clamp(0.0, MediaQuery.of(context).size.width - blockWidth);
//     // double newY = offset.dy.clamp(appBarHeight,
//     //     MediaQuery.of(context).size.height - blockHeight);
//     setState(() {
//       position = offset;
//     });
//   }

//   @override
//   void initState() {
//     position = widget.position;
//     child = widget.child;
//     innerBlock = widget.innerBlock;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var feedback = Column(
//       children: [
//         innerBlock,
//         child?.innerBlock ?? Container(),
//       ],
//     );

//     return Positioned(
//       left: position.dx,
//       top: position.dy - appBarHeight,
//       child: Draggable(
//         feedback: feedback,
//         childWhenDragging: Container(),
//         child: innerBlock,
//         onDraggableCanceled: (velocity, offset) {
//           setState(() {
//             blocks.add(ChildBlock(
//                 position: Offset(offset.dx, offset.dy + blockHeight),
//                 innerBlock: const InnerBlock(color: Colors.blue)));
//             print(blocks.length);
//           });
//           onCancle(offset, velocity);
//         },
//         onDragStarted: () {
//           setState(() {
//             blocks.removeLast();
//             print(blocks.length);
//           });
//         },
//       ),
//     );
//   }
// }

// class InnerBlock extends StatelessWidget {
//   final Color color;
//   const InnerBlock({super.key, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: blockWidth,
//       height: blockHeight,
//       color: color,
//       child: const Center(
//         child: DefaultTextStyle(
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//           ),
//           child: Text('드래그'),
//         ),
//       ),
//     );
//   }
// }

// class ChildBlock extends StatelessWidget {
//   final Offset position;
//   final InnerBlock innerBlock;
//   final ChildBlock? child;

//   const ChildBlock({
//     Key? key,
//     required this.position,
//     required this.innerBlock,
//     this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: position.dx,
//       top: position.dy - appBarHeight,
//       child: Draggable(
//         feedback: innerBlock,
//         childWhenDragging: Container(),
//         child: innerBlock,
//       ),
//     );
//   }
// }
