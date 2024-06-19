import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/Task.dart';
import 'package:todo_list_v1/providers/task_provider.dart';
import 'package:todo_list_v1/screens/tasks_details.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskPreview> createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeIn(
        duration: const Duration(milliseconds: 400),
        child: Card(
          // color: widget.task.completed
          // ? const Color.fromARGB(255, 99, 187, 64)
          // : Colors.pink[200],
          color: widget.task.completed
              ? const Color(0xFFBBDEFB)
              : const Color(0xFFFFCDD2),
          elevation: 4.0, // Ajoute une ombre portée
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Coins arrondis
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: IconButton(
              //   icon: task.completed
              //       ? const Icon(IconData(0xe04b, fontFamily: 'MaterialIcons'))
              //       : const Icon(IconData(0xee3c, fontFamily: 'MaterialIcons')),
              icon: widget.task.completed
                  ? const Icon(Icons.check_circle, color: Color(0xFF4CAF50))
                  : const Icon(Icons.circle_outlined, color: Color(0xFF4CAF50)),
              onPressed: () {
                if (widget.task.completed == false) {
                  setState(() {
                    widget.task.completed = true;
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(widget.task);
                  });
                } else {
                  setState(() {
                    widget.task.completed = false;
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(widget.task);
                  });
                }
              },
            ),
            trailing: SizedBox(
              child: IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFD32F2F)),
                onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false)
                      .deleteTask(widget.task.id!);
                },
              ),
            ),
            onTap: () {
              final result = Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TasksDetails(task: widget.task),
                ),
              );
              result.then((value) {
                if (value != null) {
                  setState(() {});
                }
              });
            },
            title: Text(
              widget.task.title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle:
                // ignore: unnecessary_null_comparison
                widget.task.content != null ? Text(widget.task.content) : null,
          ),
        ),
      ),
    );
  }
}
