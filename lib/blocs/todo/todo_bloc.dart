import 'package:bloc/bloc.dart';
import '../../repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoLoading()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        await todoRepository.addTodo(event.todo);
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      try {
        await todoRepository.updateTodo(event.todo);
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        await todoRepository.deleteTodo(event.id);
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });
  }
}
