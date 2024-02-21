import 'package:block_test/ui/programming_blocks/manager/ll.dart';
import 'package:flutter/material.dart';

class LLManager with ChangeNotifier {
  final List<LinkedList> _linkedLists = [];

  List<LinkedList> get linkedLists => _linkedLists;

  void add(LinkedList linkedList) {
    _linkedLists.add(linkedList);
    notifyListeners();
  }

  void remove(LinkedList linkedList) {
    _linkedLists.remove(linkedList);
    notifyListeners();
  }

  Widget getWidgetByIndex(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [..._linkedLists[index].toDraggable()],
    );
  }
}
