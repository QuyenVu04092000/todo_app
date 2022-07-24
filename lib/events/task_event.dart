import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();
}
class TaskEventRequested extends TaskEvent{
  final int todoId;
  const TaskEventRequested({required this.todoId}): assert(todoId != null);
  @override
  // TODO: implement props
  List<Object?> get props => [todoId];
}