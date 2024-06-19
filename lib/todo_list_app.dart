import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_v1/screens/task_form.dart';
import 'package:todo_list_v1/screens/tasks_master.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 162, 162),
      appBar: AppBar(
        title: const Text(
          'ToDo List',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 35,
              fontFamily: 'ArahLaPolice'),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(241, 230, 92, 92),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TasksForm(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: const TasksMaster(),
    );
  }
}
