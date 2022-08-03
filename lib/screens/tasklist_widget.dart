import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/task_model.dart';

class TaskListWidget extends StatelessWidget{
  final List<Task> tasks;
  final int index;
  TaskListWidget({Key? key, required this.tasks, required this.index}):
        assert(tasks != null),
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
        Text(tasks[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        SizedBox(
          height: Size.height * 0.01,
        ),
      ],
    );
  }
}