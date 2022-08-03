import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';

abstract class TodoState extends Equatable{
  const TodoState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TodoStateInitial extends TodoState{}
class TodoStateLoading extends TodoState{}
class TodoStateSuccess extends TodoState{
  final List<Todo> todos;
  const TodoStateSuccess({required this.todos});
  @override
  // TODO: implement props
  List<Object?> get props => [todos];
}
class TodoStateFail extends TodoState{}