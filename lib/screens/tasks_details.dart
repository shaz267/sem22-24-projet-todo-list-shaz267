import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/Task.dart';
import 'package:todo_list_v1/providers/task_provider.dart';
import 'package:todo_list_v1/screens/tasks_master.dart';

class TasksDetails extends StatefulWidget {
  const TasksDetails({super.key, required this.task});

  final Task task;

  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 162, 162),
      appBar: AppBar(
        title: Text(
          'Details de la tache ${widget.task.title}',
          style: const TextStyle(
            fontFamily: "AlloLaPolice",
            color: Colors.red,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormDetail(task: widget.task),
      ),
    );
  }
}

class FormDetail extends StatefulWidget {
  const FormDetail({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<FormDetail> createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: widget.task.title,
            decoration: InputDecoration(
              fillColor: Colors.grey[20],
              filled: true,
              labelText: 'Titre de la tâche',
              prefixIcon: const Icon(Icons.format_quote_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onSaved: (String? value) {
              setState(() {
                widget.task.title = value!;
              });
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            initialValue: widget.task.content,
            decoration: InputDecoration(
              fillColor: Colors.grey[20],
              filled: true,
              labelText: 'Contenu de la tache',
              prefixIcon: const Icon(Icons.document_scanner),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onSaved: (String? value) {
              setState(() {
                widget.task.content = value!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(widget.task);

                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const TasksMaster(),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('La tache a été modifiée')),
                    );
                  }
                },
                child: const Text('Sauvegarder',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
