import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/Task.dart';
import 'package:todo_list_v1/providers/task_provider.dart';
import 'package:todo_list_v1/screens/tasks_master.dart';
// import 'package:todo_list_v1/screens/tasks_master.dart';

class TasksForm extends StatefulWidget {
  const TasksForm({super.key});

  @override
  State<TasksForm> createState() => _TasksFormState();
}

class _TasksFormState extends State<TasksForm> {
  Task task = Task(completed: false, title: '', content: '', id: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 162, 162),
      appBar: AppBar(
        title: const Text('Creation d\'une tache',
            style: TextStyle(
                color: Colors.red, fontSize: 25, fontFamily: 'AlloLaPolice')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormApp(task: task),
      ),
    );
  }
}

class FormApp extends StatefulWidget {
  const FormApp({super.key, required this.task});

  final Task task;

  @override
  State<FormApp> createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey[20],
              filled: true,
              labelText: 'Titre de la tache',
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
                  backgroundColor: Color.fromARGB(255, 80, 135, 81),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Provider.of<TaskProvider>(context, listen: false)
                        .addTask(widget.task);

                    // Redirect to the previous screen
                    // Navigator.pop(context, widget.task);
                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const TasksMaster(),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('La tache a été ajoutée')),
                    );
                  }
                },
                child: const Text(
                  'Sauvegarder',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
