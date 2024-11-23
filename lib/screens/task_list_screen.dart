// import 'package:first_app_to_do_list/main.dart';
// import 'package:first_app_to_do_list/model.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TaskListScreen extends StatelessWidget {
//   const TaskListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Tasks")),
//       body: Consumer<TaskProvider>(
//         builder: (context, taskProvider, _) {
//           return ListView.builder(
//             itemCount: taskProvider.tasks.length,
//             itemBuilder: (context, index) {
//               final task = taskProvider.tasks[index];
//               return ListTile(
//                 title: Text(task.title),
//                 subtitle: Text(task.notes),
//                 trailing: Checkbox(
//                   value: task.isComplete,
//                   onChanged: (value) {
//                     final updatedTask = Task(
//                       id: task.id,
//                       title: task.title,
//                       notes: task.notes,
//                       dueDate: task.dueDate,
//                       priority: task.priority,
//                       isComplete: value!,
//                     );
//                     taskProvider.updateTask(updatedTask);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.pushNamed(context, '/add-task'),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:first_app_to_do_list/main.dart';
import 'package:first_app_to_do_list/model.dart';
import 'package:first_app_to_do_list/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return const Center(
              child: Text("No tasks available."),
            );
          }
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isComplete ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notes: ${task.notes}"),
                      Text(
                          "Due Date: ${task.dueDate.toString().split(' ')[0]}"),
                      Text("Priority: ${task.priority}"),
                    ],
                  ),
                  trailing: Checkbox(
                    value: task.isComplete,
                    onChanged: (value) {
                      final updatedTask = Task(
                        id: task.id,
                        title: task.title,
                        notes: task.notes,
                        dueDate: task.dueDate,
                        priority: task.priority,
                        isComplete: value!,
                      );
                      taskProvider.updateTask(updatedTask);
                    },
                  ),
                  onTap: () {
                    _navigateToEditScreen(context, task);
                  },
                  onLongPress: () {
                    _confirmDelete(context, task);
                  },
                  leading: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _navigateToEditScreen(context, task),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-task'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Task"),
        content:
            Text("Are you sure you want to delete the task '${task.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .deleteTask(task.id!);
              Navigator.of(ctx).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
