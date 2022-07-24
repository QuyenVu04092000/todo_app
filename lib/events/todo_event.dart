import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable{
  const TodoEvent();
}
class TodoEventRequested extends TodoEvent{
  const TodoEventRequested();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}