import 'dart:convert';
import 'package:first_app_to_do_list/main.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl =
      "https://crudcrud.com/api/663413bddd254b10b3bcb2c2df257953/tasks";

  Future<bool> addTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      if (response.statusCode == 201) {
        print("Task added successfully");
        return true;
      } else {
        print("Failed to add task: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error adding task: $e");
      return false;
    }
  }

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((task) => Task.fromJson(task)).toList();
      } else {
        print("Failed to fetch tasks: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      if (response.statusCode == 200) {
        print("Task updated successfully");
        return true;
      } else {
        print("Failed to update task: ${response.body}");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$taskId'));

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Task deleted successfully");
        return true;
      } else {
        print("Failed to delete task: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error deleting task: $e");
      return false;
    }
  }
}
