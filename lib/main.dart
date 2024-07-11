import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todo/todo_event.dart';
import 'repositories/todo_repository.dart';
import 'blocs/todo/todo_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  final TodoRepository todoRepository = TodoRepository();
  runApp(MyApp(todoRepository: todoRepository));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;

  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(todoRepository)..add(LoadTodos()),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
