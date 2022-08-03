import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repositories/todo_repository.dart';


import '../events/task_event.dart';
import '../models/task_model.dart';
import '../states/task_state.dart';

class TaskBloc extends Bloc<TaskEvent,TaskState>{
  final TodoRepository todoRepository;
  TaskBloc({required this.todoRepository}):
        super(TaskStateInitial());
  @override
  Stream<TaskState> mapEventToState(TaskEvent taskEvent) async* {
    if(taskEvent is TaskEventRequested){
      yield TaskStateLoading();
      final List<Task> tasks = await todoRepository.getTasks(taskEvent.todoId);
      yield TaskStateSuccess(tasks: tasks);
    } else if(taskEvent is TaskEventRequestedById){
      yield TaskStateLoading();
      final Task task = await todoRepository.getTaskById(taskEvent.Id);
      yield TaskByIdStateSuccess(task: task);
    } else {
      yield TaskStateFail();
    }
  }
}