import 'dart:convert';
import 'package:first_app_to_do_list/model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl =
      "https://crudcrud.com/api/1f45f0902fb74bcd8f196d87c25cbe3f/tasks";

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map<Task>((e) {
          final task = Task.fromJson(e);
          return task.copyWith(id: e['_id']);
        }).toList();
      } else {
        throw Exception(
            "Failed to fetch tasks. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception(
            "Failed to add task. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  Future<void> updateTask(Task task) async {
    if (task.id == null) {
      throw Exception("Task ID is required for updating.");
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${task.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to update task. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error updating task: $e");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to delete task. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }
}
