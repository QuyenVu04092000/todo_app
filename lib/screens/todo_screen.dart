import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/screens/task_screen.dart';
import 'package:todo_app/widgets/todolist_widget.dart';
import 'package:todo_app/states/todo_state.dart';

import '../events/todo_event.dart';

class TodoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}
class _TodoScreenState extends State<TodoScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocConsumer<TodoBloc, TodoState>(
              listener: (context, todoState){
              },
              builder: (context, todoState){
                if(todoState is TodoStateLoading){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(todoState is TodoStateSuccess){
                  final todos = todoState.todos;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: todos.length,
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
                          child: TodoListWidget(todos: todos, index: index,)
                        ),
                        onTap: () async {
                          final todoId = await todos[index].id;
                          if( todoId != null){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => TaskScreen(todoId: todoId))
                            );
                          }
                        },
                      );
                    },
                  );
                }
                if(todoState is TodoStateFail){
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
    );
  }
}