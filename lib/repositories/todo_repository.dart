import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

import '../models/task_model.dart';

const todoUrl = 'https://server-todolist2000.herokuapp.com/todos';
final taskByIdUrl = (Id) => 'https://server-todolist2000.herokuapp.com/tasks/$Id';
final tasksUrl = (todoId) => 'https://server-todolist2000.herokuapp.com/tasks/todoid/$todoId';

class TodoRepository{
  final http.Client httpClient;

  TodoRepository({required this.httpClient});

  //get Todos
  Future<List<Todo>> getTodos() async {
    final response = await httpClient.get(Uri.parse(todoUrl));
    if(response.statusCode != 200){
      throw Exception('Error getting todos');
    }
    final todos = jsonDecode(response.body)['data'] as List;
    return todos.map((e) => Todo.fromJson(e)).toList();
  }
  //get Tasks
  Future<List<Task>> getTasks(int? todoId) async {
    final response = await httpClient.get(Uri.parse(tasksUrl(todoId)));
    if(response.statusCode != 200){
      throw Exception('Error getting táks');
    }
    final tasks = jsonDecode(response.body)['data'] as List;
    return tasks.map((e) => Task.fromJson(e)).toList();
  }
  //get task from id
  Future<Task> getTaskById(int? Id) async {
    final response = await httpClient.get(Uri.parse(taskByIdUrl(Id)));
    if(response.statusCode != 200){
      throw Exception('Error getting task by id');
    }
    Map<String, dynamic> task = jsonDecode(response.body)['data'] ;
    return Task.fromJson(task);
  }
  //update task
  Future<Task> updateATask(Map<String, dynamic> params) async {
    final response = await httpClient.put(Uri.parse(taskByIdUrl(params["id"])), body: params);
    if(response.statusCode != 200){
      throw Exception('Error updating task');
    }
    final responseBody = await jsonDecode(response.body)['data'];
    return Task.fromJson(responseBody);
  }
  //delete a task
  Future<Task> deleteTask(int id) async {
    final response = await httpClient.delete(Uri.parse(taskByIdUrl(id)));
    if(response.statusCode != 200){
      throw Exception('Error deleteing task');
    }
    final responseBody = await jsonDecode(response.body);
    return Task.fromJson(responseBody);
  }
}