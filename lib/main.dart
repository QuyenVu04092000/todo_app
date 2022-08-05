import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/events/todo_event.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  final TodoRepository todoRepository = TodoRepository(
      httpClient: http.Client()
  );
  runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(todoRepository: todoRepository,), // Wrap your app
      )
  );
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;
  const MyApp({Key? key, required this.todoRepository}):
      super(key:key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc(todoRepository: todoRepository)..add(const TodoEventRequested()),
        child: TodoScreen(),
      ),
    );
  }
}