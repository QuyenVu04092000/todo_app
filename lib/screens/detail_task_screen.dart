import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../blocs/task_bloc.dart';
import '../events/task_event.dart';
import '../repositories/todo_repository.dart';
import '../states/task_state.dart';

class DetailTaskScreen extends StatefulWidget{
  final int Id;
  const DetailTaskScreen({Key? key, required this.Id}):super(key: key);
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
        title: const Text('Detail Task'),
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
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(taskState is TaskByIdStateSuccess){
                    final tasks = taskState.task;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index){
                        final Size = MediaQuery.of(context).size;
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter task's name",
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                                ),
                                autocorrect: false,
                                controller: TextEditingController(text: tasks.name),
                                textAlign: TextAlign.left,
                                onChanged: (text){
                                  setState(() {
                                    tasks.name = text;
                                  });
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Text("Finished:",style: TextStyle(fontSize: 16)),
                                    Checkbox(
                                        value: tasks.isfinished,
                                        onChanged: (bool? value){
                                          setState(() {
                                            tasks.isfinished = value!;
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
                                        child: const Text("Save"),
                                        color: Theme.of(context).colorScheme.secondary,
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