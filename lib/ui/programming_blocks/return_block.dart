import 'package:flutter/material.dart';
import 'package:block_test/programming_blocks.dart';

class ReturnBlock extends StatelessWidget {
  const ReturnBlock({
    Key? key,
    required this.color,
    required this.content,
    bool? isInput,
  })  : isInput = isInput ?? false,
        super(key: key);

  final Color color;
  final String content;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    return isInput
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: const EdgeInsets.all(1),
            child: SimpleBlock(
              color: color,
              content: content,
            ),
          )
        : SimpleBlock(
            color: color,
            content: content,
          );
  }
}
