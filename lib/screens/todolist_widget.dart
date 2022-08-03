import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListWidget extends StatelessWidget{
  final List<Todo> todos;
  final int index;
  TodoListWidget({Key? key, required this.todos, required this.index}):
      assert(todos != null),
      assert(index != null),
      super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: Size.height * 0.01,
        ),
        Text(todos[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        SizedBox(
          height: Size.height * 0.001,
        ),
        Text('Date: ${todos[index].dueDate}',style: TextStyle(fontSize: 16),),
        SizedBox(
          height: Size.height * 0.01,
        ),
      ],
    );
  }
}