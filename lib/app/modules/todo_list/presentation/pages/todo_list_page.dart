import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infrastructure/models/todo_item_model.dart';
import '../controllers/todo_list_controller.dart';
import '../widgets/delete_item_dialog.dart';
import '../widgets/new_item_dialog.dart';

class TodoListPage extends StatelessWidget {
  final _controller = Modular.get<TodoListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo-List')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => NewItemDialog(
              onAdd: (typedText) {
                _controller.addNewTodoItem(
                  TodoItemModel(
                    description: typedText,
                    value: false,
                  ),
                );

                Modular.navigator.maybePop();
              },
            ),
          ); // controller.addNewTodoItem();
        },
      ),
      body: Observer(builder: (_) {
        if (_controller.todoItems.isNotEmpty) {
          return ListView.builder(
            itemCount: _controller.todoItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_controller.todoItems.elementAt(index).description),
                trailing: Checkbox(
                  value: _controller.todoItems.elementAt(index).value,
                  onChanged: (newValue) {
                    _controller.toggleItemValue(
                      itemIndex: index,
                      newValue: newValue,
                    );
                  },
                ),
                onLongPress: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DeleteItemDialog(
                      onDelete: () {
                        _controller.deleteTodoItem(itemIndex: index);

                        Modular.navigator.maybePop();
                      },
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'Items will be shown here when you add them',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        }
      }),
    );
  }
}
