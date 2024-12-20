import 'package:first_app_to_do_list/api.dart';
import 'package:first_app_to_do_list/model.dart';

import 'package:first_app_to_do_list/screens/edit_task_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        home: const TaskListScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/add-task': (_) => TaskFormScreen(),
        },
      ),
    );
  }
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _service = TaskService();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await _service.fetchTasks();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _service.addTask(task);
      await fetchTasks();
    } catch (e) {
      debugPrint('Error adding task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _service.updateTask(task);
      await fetchTasks();
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _service.deleteTask(id);
      await fetchTasks();
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }
}
