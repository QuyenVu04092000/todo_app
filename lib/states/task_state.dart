import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';

import '../models/task_model.dart';

abstract class TaskState extends Equatable{
  const TaskState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TaskStateInitial extends TaskState{}
class TaskStateLoading extends TaskState{}
class TaskStateSuccess extends TaskState{
  final List<Task> tasks;
  const TaskStateSuccess({required this.tasks}):
        assert(tasks != null);
  @override
  // TODO: implement props
  List<Object?> get props => [tasks];
}
class TaskStateFail extends TaskState{}
class TaskByIdStateSuccess extends TaskState{
  final List<Task> task;
  const TaskByIdStateSuccess({required this.task}):
        assert(task != null);
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}