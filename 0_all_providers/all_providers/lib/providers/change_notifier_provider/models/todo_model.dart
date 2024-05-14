import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Todo {
  String id;
  String desc;
  bool completed;

  Todo({
    required this.id,
    required this.desc,
    this.completed = false,
  });

  factory Todo.add({required String desc}) {
    return Todo(id: uuid.v4(), desc: desc);
  }


  @override
  String toString() {
    return 'Todo{id: $id, desc: $desc, complete: $completed}';
  }

  Todo copyWith({
    String? id,
    String? desc,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      completed: completed ?? this.completed,
    );
  }

}
