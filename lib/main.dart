import 'package:first_app_to_do_list/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> jsonData = json.decode(tasksString);
      _tasks = jsonData.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksString =
        json.encode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksString);
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }
}

class Task {
  final String id;
  final String title;
  final String notes;
  final DateTime dueDate;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.notes,
    required this.dueDate,
    this.isComplete = false,
    required String priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        notes: json['notes'],
        dueDate: DateTime.parse(json['dueDate']),
        isComplete: json['isComplete'],
        priority: '',
      );

  String? get priority => null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'notes': notes,
        'dueDate': dueDate.toIso8601String(),
        'isComplete': isComplete,
      };
}
