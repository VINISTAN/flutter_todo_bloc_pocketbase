import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoRepository {
  final String baseUrl = "http://127.0.0.1:8090";

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("Response : ${response.statusCode}");
    print("Response : ${response.body}");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/todos/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
