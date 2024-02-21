import 'package:flutter/material.dart';
import 'package:block_test/programming_blocks.dart';

class BlockByShape extends StatelessWidget {
  final ProgrammingBlockShape shape;
  final Color color;
  final String content;

  const BlockByShape({
    Key? key,
    required this.shape,
    required this.color,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (shape) {
      case ProgrammingBlockShape.simple:
        return SimpleBlock(
          color: color,
          content: content,
        );
      case ProgrammingBlockShape.withReturn:
        return ReturnBlock(
          color: color,
          content: content,
        );
    }
  }
}

enum ProgrammingBlockShape {
  simple,
  withReturn,
}
