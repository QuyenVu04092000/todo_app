import 'package:equatable/equatable.dart';

class Task extends Equatable {
  int id;
  String name;
  bool isfinished;
  int todoId;

  Task({
    required this.id,
    required this.todoId,
    required this.name,
    required this.isfinished,
  });
  @override
  List<Object> get props => [
    id,
    todoId,
    name,
    isfinished
  ];
  //convert from JSON to Todo object
  factory Task.fromJson(dynamic jsonObject){
    return Task(
        id: jsonObject['id'] ,
        todoId: jsonObject['todoid'] ,
        name: jsonObject['name'],
        isfinished: jsonObject['isfinished']
    );
  }
  //clone a Task
  factory Task.fromTask(Task anotherTask){
    return Task(
      id: anotherTask.id,
      name: anotherTask.name,
      isfinished: anotherTask.isfinished,
      todoId: anotherTask.todoId
    );
  }
}