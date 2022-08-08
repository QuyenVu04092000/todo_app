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
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      _controller.value = _controller.value.copyWith(
        text: _controller.text,
        selection: 
          TextSelection(baseOffset: _controller.text.length, extentOffset:  _controller.text.length),
        composing: TextRange.empty,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final TodoRepository todoRepository = TodoRepository(
        httpClient: http.Client()
    );
    final Size = MediaQuery.of(context).size;
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
                    final task = taskState.task;
                    return Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter new task's name you want to change",
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                                ),
                                autocorrect: false,
                                controller: _controller,
                                textAlign: TextAlign.left,
                                onChanged: (text){
                                  setState(() {
                                    task.name = text;
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
                                        child: const Text("Save"),
                                        color: Theme.of(context).accentColor,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        onPressed: () {
                                          Map<String, dynamic> params = Map<String, dynamic>();
                                          params["id"] = task.id.toString();
                                          params["name"] = task.name;
                                          params["isfinished"] = task.isfinished ? "1" : "0";
                                          params["todoid"] = task.todoId.toString();
                                          todoRepository.updateATask(params);
                                          Navigator.pop(
                                            context,
                                            ModalRoute.withName(Navigator.defaultRouteName),
                                          );
                                        },
                                      )
                                  ),
                                  SizedBox(
                                    width: Size.width * 0.02,
                                  ),
                                  Expanded(
                                      child: RaisedButton(
                                        child: const Text("Delete"),
                                        color: Colors.redAccent,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                        ),
                                        onPressed: () {
                                          todoRepository.deleteTask(widget.Id);
                                          Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(Navigator.defaultRouteName),
                                          );
                                        },
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
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