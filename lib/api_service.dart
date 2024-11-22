import 'dart:convert';
import 'package:first_app_to_do_list/main.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://cac071342108970a05be.free.beeceptor.com/api/users/';

  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_AUTH_TOKEN',
      };

  Future<List<Task>> getTasks() async {
    final response =
        await http.get(Uri.parse('$baseUrl/tasks'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((taskJson) => Task.fromJson(taskJson)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<bool> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: headers,
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<bool> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/${task.id}'),
      headers: headers,
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<bool> deleteTask(String taskId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
