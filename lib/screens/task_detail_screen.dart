// import 'package:first_app_to_do_list/main.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TaskDetailScreen extends StatelessWidget {
//   final Task task;
//   const TaskDetailScreen({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TaskProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(task.title),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Card for Task Details
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Task Title
//                     Text(
//                       task.title,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // Due Date
//                     Row(
//                       children: [
//                         const Icon(Icons.calendar_today, color: Colors.grey),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Due Date: ${task.dueDate.toLocal()}'.split(' ')[0],
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     // Notes Section
//                     const Text(
//                       'Notes:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       task.notes.isNotEmpty
//                           ? task.notes
//                           : 'No additional notes',
//                       style:
//                           const TextStyle(fontSize: 16, color: Colors.black87),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Delete Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   taskProvider.deleteTask(task.id);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 24.0, vertical: 12.0),
//                   backgroundColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 child: const Text(
//                   'Delete Task',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:first_app_to_do_list/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          'Due Date: ${task.dueDate.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Notes:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.notes.isNotEmpty
                          ? task.notes
                          : 'No additional notes',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  taskProvider.deleteTask(task.id);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Delete Task',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
