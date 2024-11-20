import 'package:first_app_to_do_list/screens/api_service.dart';
import 'package:first_app_to_do_list/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) =>
            auth.isAuthenticated ? const TaskListScreen() : const LoginScreen(),
      ),
    );
  }
}

// Authentication Provider
class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    // Add your login logic here (e.g., API call for authentication)
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

// Task Provider
class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  final ApiService apiService = ApiService();

  // Load tasks from API
  Future<void> loadTasks() async {
    try {
      _tasks = await apiService.getTasks();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    }
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    try {
      bool isSuccess = await apiService.addTask(task);
      if (isSuccess) {
        _tasks.add(task);
        notifyListeners();
      } else {
        debugPrint("Error adding task");
      }
    } catch (e) {
      debugPrint("Error adding task: $e");
    }
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    try {
      bool isSuccess = await apiService.updateTask(task);
      if (isSuccess) {
        int index = _tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          _tasks[index] = task;
          notifyListeners();
        }
      } else {
        debugPrint("Error updating task");
      }
    } catch (e) {
      debugPrint("Error updating task: $e");
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      bool isSuccess = await apiService.deleteTask(taskId);
      if (isSuccess) {
        _tasks.removeWhere((task) => task.id == taskId);
        notifyListeners();
      } else {
        debugPrint("Error deleting task");
      }
    } catch (e) {
      debugPrint("Error deleting task: $e");
    }
  }
}

// Task Model
class Task {
  String id;
  String title;
  String notes;
  DateTime dueDate;
  bool isComplete;
  String priority;

  Task({
    required this.id,
    required this.title,
    required this.notes,
    required this.dueDate,
    required this.isComplete,
    required this.priority,
  });

  // Convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'dueDate': dueDate.toIso8601String(),
      'isComplete': isComplete,
      'priority': priority,
    };
  }

  // Create Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Untitled',
      notes: json['notes'] ?? '',
      dueDate:
          DateTime.parse(json['dueDate'] ?? DateTime.now().toIso8601String()),
      isComplete: json['isComplete'] ?? false,
      priority: json['priority'] ?? 'Low',
    );
  }
}
