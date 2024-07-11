import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo/todo_bloc.dart';
import '../blocs/todo/todo_event.dart';
import '../models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  final _titleController = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final todo = Todo(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  isCompleted: false,
                );
                BlocProvider.of<TodoBloc>(context).add(AddTodo(todo));
                Navigator.of(context).pop();
              },
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
