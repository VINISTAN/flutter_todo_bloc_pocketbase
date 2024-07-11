import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo/todo_bloc.dart';
import '../blocs/todo/todo_event.dart';
import '../models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (bool? value) {
          BlocProvider.of<TodoBloc>(context).add(UpdateTodo(
            todo.copyWith(isCompleted: value!),
          ));
        },
      ),
      onLongPress: () {
        BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo.id));
      },
    );
  }
}
