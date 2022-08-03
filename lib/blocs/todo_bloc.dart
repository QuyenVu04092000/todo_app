import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/events/todo_event.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/states/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
  final TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}):
      super(TodoStateInitial());
  @override
  Stream<TodoState> mapEventToState(TodoEvent todoEvent) async* {
    if(todoEvent is TodoEventRequested){
      yield TodoStateLoading();
      final List<Todo> todos = await todoRepository.getTodos();
      yield TodoStateSuccess(todos: todos);
    } else {
      yield TodoStateFail();
    }
  }
}