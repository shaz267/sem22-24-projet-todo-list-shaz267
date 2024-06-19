import 'package:flutter/material.dart';
// import 'package:faker/faker.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/Task.dart';
import 'package:todo_list_v1/providers/task_provider.dart';
import 'package:todo_list_v1/screens/tasks_preview.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  _TasksMasterState();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, tasksProvider, child) {
      return FutureBuilder(
          future: tasksProvider.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Vous n\'avez pas encore de tâche'));
            } else {
              return ListView.builder(
                  itemCount: tasksProvider.tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasksProvider.tasks[index];
                    return TaskPreview(task: task);
                  });
            }
          });
    });
  }

  // FAKER
  // Future<List<Task>> _fetchTasks() async {
  //   var faker = Faker();
  //   List<Task> tasks = List.generate(100, (index) {
  //     return Task(
  //         completed: faker.randomGenerator.boolean(),
  //         content: faker.lorem.sentence(),
  //         title: faker.lorem.word(),
  //         id: index);
  //   });

  //   if (tasks.isNotEmpty) {
  //     tasks.insertAll(0, this.tasks);
  //   }

  //   return tasks;
  // }
}
