import 'package:first_app_to_do_list/main.dart';
import 'package:first_app_to_do_list/screens/api_service.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    tasks = await _apiService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    try {
      bool success = await _apiService.addTask(task);
      if (success) {
        tasks.add(task);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      bool success = await _apiService.updateTask(updatedTask);
      if (success) {
        int index = tasks.indexWhere((task) => task.id == updatedTask.id);
        if (index != -1) {
          tasks[index] = updatedTask;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error updating task: $e");
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      bool success = await _apiService.deleteTask(taskId);
      if (success) {
        tasks.removeWhere((task) => task.id == taskId);
        notifyListeners();
      }
    } catch (e) {
      print("Error deleting task: $e");
    }
  }
}
