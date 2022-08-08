import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String name;
  final String des;

  const Todo({
    required this.id,
    required this.name,
    required this.des
  });
  @override
  List<Object> get props => [
    id,
    name,
    des
  ];
  //convert from JSON to Todo object
  factory Todo.fromJson(dynamic jsonObject){
    return Todo(
      id: jsonObject['id'] as int,
      name: jsonObject['name'].toString(),
      des: jsonObject['description']
    );
  }
}