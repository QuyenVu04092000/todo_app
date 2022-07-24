import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String name;
  final String dueDate;
  final String des;

  const Todo({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.des
  });
  @override
  List<Object> get props => [
    id,
    name,
    dueDate,
    des
  ];
  //convert from JSON to Todo object
  factory Todo.fromJson(dynamic jsonObject){
    return Todo(
      id: jsonObject['id'] as int,
      name: jsonObject['name'].toString(),
      dueDate: jsonObject['duedate'],
      des: jsonObject['description']
    );
  }
}