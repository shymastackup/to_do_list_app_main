// import 'dart:convert';

// import 'package:first_app_to_do_list/model.dart';
// import 'package:http/http.dart' as http;

// class TaskService {
//   final String baseUrl =
//       "https://crudcrud.com/api/a6fc9992afb0408bb24ab169be701930/tasks";

//   Future<List<Task>> fetchTasks() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//       return data.map((e) => Task.fromJson(e)).toList();
//     } else {
//       throw Exception("Failed to load tasks");
//     }
//   }

//   Future<void> addTask(Task task) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(task.toJson()),
//     );
//     if (response.statusCode != 201) {
//       throw Exception("Failed to add task");
//     }
//   }

//   Future<void> updateTask(Task task) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/${task.id}'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(task.toJson()),
//     );
//     if (response.statusCode != 200) {
//       throw Exception("Failed to update task");
//     }
//   }

//   Future<void> deleteTask(String id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//     if (response.statusCode != 200) {
//       throw Exception("Failed to delete task");
//     }
//   }
// }

import 'dart:convert';
import 'package:first_app_to_do_list/model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl =
      "https://crudcrud.com/api/7028c90e613c4d9e9e110e6878a792a2/tasks";

  /// Fetch all tasks from the API
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map<Task>((e) {
          final task = Task.fromJson(e);
          return task.copyWith(
              id: e['_id']); // Assign API-generated `_id` to Task `id`
        }).toList();
      } else {
        throw Exception(
            "Failed to fetch tasks. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }
  }

  /// Add a new task to the API
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

  /// Update an existing task on the API
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

  /// Delete a task from the API
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
