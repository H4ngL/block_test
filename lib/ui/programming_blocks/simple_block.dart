import 'package:flutter/material.dart';

class SimpleBlock extends StatelessWidget {
  const SimpleBlock({
    Key? key,
    required this.color,
    required this.content,
    this.headerOfScopeBlock = false,
  }) : super(key: key);

  final Color color;
  final String content;
  final bool headerOfScopeBlock;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return _DragTargetBody(
        headerOfScopeBlock: headerOfScopeBlock,
        color: color,
        content: content,
      );
    });
  }
}

class _DragTargetBody extends StatelessWidget {
  const _DragTargetBody({
    Key? key,
    required this.headerOfScopeBlock,
    required this.color,
    required this.content,
  }) : super(key: key);

  final bool headerOfScopeBlock;
  final Color color;
  final String content;

  @override
  Widget build(BuildContext context) {
    return _Body(
      color: color,
      headerOfScopeBlock: headerOfScopeBlock,
      content: content,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.color,
    required this.content,
    required this.headerOfScopeBlock,
  }) : super(key: key);

  final Color color;
  final String content;
  final bool headerOfScopeBlock;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: widget.headerOfScopeBlock
            ? const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              )
            : const BorderRadius.all(
                Radius.circular(4.0),
              ),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Text(widget.content),
      ),
    );
  }
}
