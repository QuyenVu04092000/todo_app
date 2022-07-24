import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/events/task_event.dart';
import 'package:todo_app/states/task_state.dart';
import '../repositories/todo_repository.dart';

class TaskScreen extends StatefulWidget{
  final int todoId;
  TaskScreen({required this.todoId});
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
        title: Text('List of tasks'),
        actions: <Widget>[
          IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.add),
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
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(taskState is TaskStateSuccess){
                    final tasks = taskState.tasks;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index){
                        final Size = MediaQuery.of(context).size;
                        return GestureDetector(
                          child: Card(
                            margin: EdgeInsets.only(top: 15,left: 10, right: 10),
                            elevation: 15,
                            shape:
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(width: 3, color: Colors.black)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: Size.height * 0.01,
                                  ),
                                  Text(tasks[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  SizedBox(
                                    height: Size.height * 0.01,
                                  ),
                                ],
                              ),
                            )
                          ),
                          onTap: () async {},
                        );
                      },
                    );
                  }
                  if(taskState is TaskStateFail){
                    return Center(
                        child: Text('Can connect to server',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16
                          ),)
                    );
                  }
                  return Center(
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