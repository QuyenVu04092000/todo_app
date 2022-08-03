import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../blocs/task_bloc.dart';
import '../events/task_event.dart';
import '../models/task_model.dart';
import '../repositories/todo_repository.dart';
import '../states/task_state.dart';

class DetailTaskScreen extends StatefulWidget{
  final int Id;
  DetailTaskScreen({Key? key, required this.Id}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailTaskState();
  }
}
class _DetailTaskState extends State<DetailTaskScreen>{
  @override
  Widget build(BuildContext context) {
    final TodoRepository todoRepository = TodoRepository(
        httpClient: http.Client()
    );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Detail Task'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create:  (context) => TaskBloc(todoRepository: todoRepository)..add(TaskEventRequestedById(Id: widget.Id)),
          child: SingleChildScrollView(
            child: Center(
              child: BlocConsumer<TaskBloc, TaskState>(
                listener: (context, taskState){
                },
                builder: (context, taskState){
                  if(taskState is TaskStateLoading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(taskState is TaskByIdStateSuccess){
                    final tasks = taskState.task;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index){
                        final Size = MediaQuery.of(context).size;
                        final task = tasks[0];
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Enter task's name",
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                                ),
                                autocorrect: false,
                                controller: TextEditingController(text: task.name),
                                textAlign: TextAlign.left,
                                onChanged: (text){
                                  setState(() {
                                    task.name = text;
                                  });
                                },
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Finished:",style: TextStyle(fontSize: 16)),
                                    Checkbox(
                                        value: task.isfinished,
                                        onChanged: (bool? value){
                                          setState(() {
                                            task.isfinished = value!;
                                          });
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: RaisedButton(
                                        child: Text("Save"),
                                        color: Theme.of(context).accentColor,
                                        elevation: 4,
                                        onPressed: (){

                                        },
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
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