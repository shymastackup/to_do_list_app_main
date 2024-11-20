// ignore_for_file: library_private_types_in_public_api

import 'package:first_app_to_do_list/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController notesController;
  DateTime? selectedDate;
  String? selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    notesController = TextEditingController(text: widget.task.notes);
    selectedDate = widget.task.dueDate;
    selectedPriority = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Task',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  selectedDate == null
                      ? 'Select Due Date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: TextStyle(
                      fontSize: 16,
                      color: selectedDate == null ? Colors.grey : Colors.black),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Pick a Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPriority,
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              items: ['Low', 'Medium', 'High'].map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPriority = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    final updatedTask = Task(
                      id: widget.task.id,
                      title: titleController.text,
                      notes: notesController.text,
                      dueDate: selectedDate ?? DateTime.now(),
                      priority: selectedPriority ?? 'Low',
                      isComplete: widget.task.isComplete,
                    );
                    taskProvider.updateTask(updatedTask);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Title is required')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Save Changes',
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
