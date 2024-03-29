import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();
}
class TaskEventRequested extends TaskEvent{
  final int todoId;
  const TaskEventRequested({required this.todoId});
  @override
  // TODO: implement props
  List<Object?> get props => [todoId];
}
class TaskEventRequestedById extends TaskEvent{
  final int Id;
  const TaskEventRequestedById({required this.Id});
  @override
  // TODO: implement props
  List<Object?> get props => [Id];
}