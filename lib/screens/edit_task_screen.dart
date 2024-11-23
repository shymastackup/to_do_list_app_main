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

    return Scaffold(
      appBar: AppBar(title: Text(task == null ? "New Task" : "Edit Task")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: "Title"),
                onChanged: (value) => title = value,
              ),
              TextFormField(
                initialValue: notes,
                decoration: const InputDecoration(labelText: "Notes"),
                onChanged: (value) => notes = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: task?.id ?? DateTime.now().toString(),
                      title: title,
                      notes: notes,
                      dueDate: DateTime.now(),
                      priority: '',
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
                child: Text(task == null ? "Save Task" : "Update Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
