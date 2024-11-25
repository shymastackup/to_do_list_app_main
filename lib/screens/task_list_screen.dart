// import 'package:first_app_to_do_list/main.dart';
// import 'package:first_app_to_do_list/model.dart';
// import 'package:first_app_to_do_list/screens/edit_task_screen.dart';
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
//           if (taskProvider.tasks.isEmpty) {
//             return const Center(
//               child: Text("No tasks available."),
//             );
//           }
//           return ListView.builder(
//             itemCount: taskProvider.tasks.length,
//             itemBuilder: (context, index) {
//               final task = taskProvider.tasks[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 elevation: 2,
//                 child: ListTile(
//                   title: Text(
//                     task.title,
//                     style: TextStyle(
//                       decoration:
//                           task.isComplete ? TextDecoration.lineThrough : null,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Notes: ${task.notes}"),
//                       Text(
//                           "Due Date: ${task.dueDate.toString().split(' ')[0]}"),
//                       Text("Priority: ${task.priority}"),
//                     ],
//                   ),
//                   trailing: Checkbox(
//                     value: task.isComplete,
//                     onChanged: (value) {
//                       final updatedTask = Task(
//                         id: task.id,
//                         title: task.title,
//                         notes: task.notes,
//                         dueDate: task.dueDate,
//                         priority: task.priority,
//                         isComplete: value!,
//                       );
//                       taskProvider.updateTask(updatedTask);
//                     },
//                   ),
//                   onTap: () {
//                     _navigateToEditScreen(context, task);
//                   },
//                   onLongPress: () {
//                     _confirmDelete(context, task);
//                   },
//                   leading: IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () => _navigateToEditScreen(context, task),
//                   ),
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

//   void _navigateToEditScreen(BuildContext context, Task task) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TaskFormScreen(task: task),
//       ),
//     );
//   }

//   void _confirmDelete(BuildContext context, Task task) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Delete Task"),
//         content:
//             Text("Are you sure you want to delete the task '${task.title}'?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Provider.of<TaskProvider>(context, listen: false)
//                   .deleteTask(task.id!);
//               Navigator.of(ctx).pop();
//             },
//             child: const Text("Delete"),
//           ),
//         ],
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
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return const Center(
              child: Text(
                "No tasks available.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: "Edit Task",
                    onPressed: () => _navigateToEditScreen(context, task),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration:
                          task.isComplete ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notes: ${task.notes}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Due Date: ${task.dueDate.toString().split(' ')[0]}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Priority: ${task.priority}",
                          style: TextStyle(
                            fontSize: 14,
                            color: task.priority == "High"
                                ? Colors.red
                                : task.priority == "Medium"
                                    ? Colors.orange
                                    : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.isComplete,
                        onChanged: (value) {
                          final updatedTask = task.copyWith(
                            isComplete: value!,
                          );
                          taskProvider.updateTask(updatedTask);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: "Delete Task",
                        onPressed: () => _confirmDelete(context, task),
                      ),
                    ],
                  ),
                  onTap: () {
                    _navigateToEditScreen(context, task);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-task'),
        backgroundColor: Colors.blueAccent,
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
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text("Delete Task"),
          ],
        ),
        content:
            Text("Are you sure you want to delete the task '${task.title}'?"),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(ctx).pop(),
            icon: const Icon(Icons.cancel, color: Colors.grey),
            label: const Text("Cancel"),
          ),
          TextButton.icon(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .deleteTask(task.id!);
              Navigator.of(ctx).pop();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
