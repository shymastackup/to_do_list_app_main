import 'package:first_app_to_do_list/main.dart';
import 'package:first_app_to_do_list/screens/new_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: taskProvider.tasks.isEmpty
            ? const Center(
                child: Text(
                  'No tasks yet! Add a new task using the + button.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: task.isComplete ? Colors.grey : Colors.black,
                          decoration: task.isComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        'Due: ${task.dueDate.toLocal()}'.split(' ')[0],
                        style: TextStyle(
                          color: task.isComplete ? Colors.grey : Colors.black54,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          task.isComplete ? Icons.check_circle : Icons.circle,
                          color: task.isComplete ? Colors.green : Colors.blue,
                        ),
                        onPressed: () {
                          taskProvider
                              .updateTask(task..isComplete = !task.isComplete);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTaskScreen()),
          );
        },
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
