import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/todo_item.dart';

class TodoItemModel extends TodoItem {
  TodoItemModel({
    @required description,
    @required value,
  }) : super(description: description, value: value);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'value': value,
    };
  }

  factory TodoItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TodoItemModel(
      description: map['description'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItemModel.fromJson(String source) =>
      TodoItemModel.fromMap(json.decode(source));

  TodoItemModel copyWith({String description, bool value}) {
    return TodoItemModel(
      description: description ?? this.description,
      value: value ?? this.value,
    );
  }

  factory TodoItemModel.fromEntity({@required TodoItem item}) {
    if (item == null) return null;

    return TodoItemModel(description: item.description, value: item.value);
  }
}
