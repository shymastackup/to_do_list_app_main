import 'package:first_app_to_do_list/api.dart';
import 'package:first_app_to_do_list/model.dart';
import 'package:flutter/material.dart';


class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _service = TaskService();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _service.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _service.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _service.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(String id) async {
    await _service.deleteTask(id);
    await fetchTasks();
  }
}
