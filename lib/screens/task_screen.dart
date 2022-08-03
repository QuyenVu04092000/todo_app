import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/events/task_event.dart';
import 'package:todo_app/widgets/tasklist_widget.dart';
import 'package:todo_app/states/task_state.dart';
import '../repositories/todo_repository.dart';
import 'detail_task_screen.dart';

class TaskScreen extends StatefulWidget{
  final int todoId;
  const TaskScreen({required this.todoId});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TaskScreenState();
  }
}
class _TaskScreenState extends State<TaskScreen>{
  final TodoRepository todoRepository = TodoRepository(
      httpClient: http.Client()
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('List of tasks'),
        actions: <Widget>[
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          create:  (context) => TaskBloc(todoRepository: todoRepository)..add(TaskEventRequested(todoId: widget.todoId)),
          child: SingleChildScrollView(
            child: Center(
              child: BlocConsumer<TaskBloc, TaskState>(
                listener: (context, taskState){
                },
                builder: (context, taskState){
                  if(taskState is TaskStateLoading){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(taskState is TaskStateSuccess){
                    final tasks = taskState.tasks;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index){
                        final Size = MediaQuery.of(context).size;
                        return GestureDetector(
                          child: Card(
                            margin: const EdgeInsets.only(top: 15,left: 10, right: 10),
                            elevation: 15,
                            shape:
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(width: 3, color: Colors.black)
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child:TaskListWidget(tasks: tasks, index: index,)
                            )
                          ),
                          onTap: () async {
                            final Id = tasks[index].id;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DetailTaskScreen(Id: Id))
                            );
                          },
                        );
                      },
                    );
                  }
                  if(taskState is TaskStateFail){
                    return const Center(
                        child: Text('Can connect to server',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16
                          ),)
                    );
                  }
                  return const Center(
                    child: Text('error'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}