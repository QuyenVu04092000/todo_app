import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

import '../models/task_model.dart';

const todoUrl = 'http://localhost:3000/todos';
final taskUrl = (todoId) => 'http://localhost:3000/tasks/todoid/${todoId}';
class TodoRepository{
  final http.Client httpClient;

  TodoRepository({required this.httpClient}): assert(httpClient != null);

  //get Todos
  Future<List<Todo>> getTodos() async {
    final response = await this.httpClient.get(Uri.parse(todoUrl));
    if(response.statusCode != 200){
      throw Exception('Error getting todos');
    }
    final todos = jsonDecode(response.body)['data'] as List;
    return todos.map((e) => Todo.fromJson(e)).toList();
  }
  //get Tasks
  Future<List<Task>> getTasks(int? todoId) async {
    final response = await this.httpClient.get(Uri.parse(taskUrl(todoId)));
    if(response.statusCode != 200){
      throw Exception('Error getting todos');
    }
    final tasks = jsonDecode(response.body)['data'] as List;
    return tasks.map((e) => Task.fromJson(e)).toList();
  }
}