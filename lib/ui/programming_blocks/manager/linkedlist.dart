import 'package:flutter/material.dart';

class Node2 {
  Node2? next;
  Node2? prev;
  Widget? widget;
  Node2({this.next, this.prev, this.widget});
}

const plus = 4;

class LinkedList2 {
  Node2? head;
  Node2? tail;
  int length = 0;

  int get size => length;

  Node2 add() {
    Node2 node = Node2();
    if (head == null) {
      head = node;
      tail = node;
    } else {
      tail!.next = node;
      node.prev = tail;
      tail = node;
    }
    length++;
    return node;
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
  }

  void remove(Node2 node) {
    if (node.prev == null) {
      removeFirst();
    } else if (node.next == null) {
      removeLast();
    } else {
      node.prev!.next = node.next;
      node.next!.prev = node.prev;
      length--;
    }
  }

  void cut(Node2 node) {
    Node2 prev = node.prev!;

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
  }

  int lengthFromNode(Node2 node) {
    int count = 0;
    while (node.next != null) {
      count++;
      node = node.next!;
    }
    return count + 1;
  }

  void insertAfter(Node2? node, Widget widget) {
    Node2 newNode = Node2(widget: widget);
    if (node!.next == null) {
      tail = newNode;
    } else {
      node.next!.prev = newNode;
      newNode.next = node.next;
    }
    node.next = newNode;
    newNode.prev = node;
    length++;
  }

  void insertBefore(Node2 node, Widget widget) {
    Node2 newNode = Node2(widget: widget);
    if (node.prev == null) {
      head = newNode;
    } else {
      node.prev!.next = newNode;
      newNode.prev = node.prev;
    }
    node.prev = newNode;
    newNode.next = node;
    length++;
  }

  List<Widget> toList() {
    List<Widget> list = [];
    Node2? node = head;
    while (node != null) {
      list.add(node.widget!);
      node = node.next;
    }
    return list;
  }

  void clear() {
    head = null;
    tail = null;
    length = 0;
  }
}
