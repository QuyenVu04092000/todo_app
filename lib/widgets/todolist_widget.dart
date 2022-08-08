import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListWidget extends StatelessWidget{
  final List<Todo> todos;
  final int index;
  const TodoListWidget({Key? key, required this.todos, required this.index}):
      super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: Size.height * 0.01,
        ),
        Text(todos[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        SizedBox(
          height: Size.height * 0.01,
        ),
      ],
    );
  }
}