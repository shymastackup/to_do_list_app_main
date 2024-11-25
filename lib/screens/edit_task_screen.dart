// import 'package:first_app_to_do_list/main.dart';
// import 'package:first_app_to_do_list/model.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TaskFormScreen extends StatelessWidget {
//   final Task? task;

//   const TaskFormScreen({super.key, this.task});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     String title = task?.title ?? '';

//     String notes = task?.notes ?? '';

//     return Scaffold(
//       appBar: AppBar(title: Text(task == null ? "New Task" : "Edit Task")),
//       body: Form(
//         key: formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: title,
//                 decoration: const InputDecoration(labelText: "Title"),
//                 onChanged: (value) => title = value,
//               ),
//               TextFormField(
//                 initialValue: notes,
//                 decoration: const InputDecoration(labelText: "Notes"),
//                 onChanged: (value) => notes = value,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     final newTask = Task(
//                       id: task?.id ?? DateTime.now().toString(),
//                       title: title,
//                       notes: notes,
//                       dueDate: DateTime.now(),
//                       priority: '',
//                     );
//                     if (task == null) {
//                       Provider.of<TaskProvider>(context, listen: false)
//                           .addTask(newTask);
//                     } else {
//                       Provider.of<TaskProvider>(context, listen: false)
//                           .updateTask(newTask);
//                     }
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text(task == null ? "Save Task" : "Update Task"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:first_app_to_do_list/main.dart';
import 'package:first_app_to_do_list/model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskFormScreen extends StatelessWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = task?.title ?? '';
    String notes = task?.notes ?? '';
    String priority = task?.priority ?? 'Medium';

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? "New Task" : "Edit Task"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Task Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter task title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onChanged: (value) => title = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: notes,
                decoration: InputDecoration(
                  labelText: "Notes",
                  hintText: "Add additional details (optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                maxLines: 3,
                onChanged: (value) => notes = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: priority,
                decoration: InputDecoration(
                  labelText: "Priority",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                items: ['Low', 'Medium', 'High']
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) => priority = value ?? 'Medium',
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newTask = Task(
                        id: task?.id ?? DateTime.now().toString(),
                        title: title,
                        notes: notes,
                        dueDate: DateTime.now(),
                        priority: priority,
                      );
                      if (task == null) {
                        Provider.of<TaskProvider>(context, listen: false)
                            .addTask(newTask);
                      } else {
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(newTask);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    task == null ? "Save Task" : "Update Task",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
