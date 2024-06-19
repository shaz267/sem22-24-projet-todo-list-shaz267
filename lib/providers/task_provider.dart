import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list_v1/models/Task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  Future<List<Task>> getTasks() async {
    if (tasks.isEmpty) {
      await _fetchTasks();
    }

    return tasks;
  }

  Future<void> _fetchTasks() async {
    var response = await Supabase.instance.client.from('tache').select();

    for (var element in response as List) {
      tasks.add(Task(
          completed: element['completed'],
          title: element['title'],
          content: element['content'],
          id: element['id']));
    }
  }

  Future<void> addTask(Task task) async {
    final response = await Supabase.instance.client.from('tache').insert({
      'completed': task.completed,
      'title': task.title,
      'content': task.content,
    }).select();

    Task newTask = Task(
        completed: response.first['completed'],
        title: response.first['title'],
        content: response.first['content'],
        id: response.first['id']);

    tasks.add(newTask);

    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await Supabase.instance.client.from('tache').delete().eq('id', id);
    tasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await Supabase.instance.client.from('tache').update(
      {
        'completed': task.completed,
        'title': task.title,
        'content': task.content,
      },
    ).eq('id', task.id as int);
    notifyListeners();
  }
}
