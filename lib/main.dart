import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list_v1/providers/task_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'todo_list_app.dart';

/**
 * Fonction main pour lancer l'application
 */
Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");

  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_API_KEY']!);

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const ToDoListApp(),
    ),
  );
}
