import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/screens/task_screen.dart';
import 'package:todo_app/widgets/todolist_widget.dart';
import 'package:todo_app/states/todo_state.dart';


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
        title: const Text('Todo List'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.add),
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
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(todoState is TodoStateSuccess){
                  final todos = todoState.todos;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: todos.length,
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
                          child: TodoListWidget(todos: todos, index: index,)
                        ),
                        onTap: () async {
                          final todoId = todos[index].id;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TaskScreen(todoId: todoId))
                          );
                        },
                      );
                    },
                  );
                }
                if(todoState is TodoStateFail){
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
    );
  }
}