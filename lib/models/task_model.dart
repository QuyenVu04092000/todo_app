import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String name;
  final String isfinished;

  const Task({
    required this.name,
    required this.isfinished,
  });
  @override
  List<Object> get props => [
    name,
    isfinished
  ];
  //convert from JSON to Todo object
  factory Task.fromJson(dynamic jsonObject){
    return Task(
        name: jsonObject['name'].toString(),
        isfinished: jsonObject['isfinished'].toString()
    );
  }
}