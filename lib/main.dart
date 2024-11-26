import 'package:first_app_to_do_list/api.dart';
import 'package:first_app_to_do_list/model.dart';
import 'package:first_app_to_do_list/provider.dart';
import 'package:first_app_to_do_list/screens/edit_task_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        home: const TaskListScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/add-task': (_) => TaskFormScreen(),
        },
      ),
    );
  }
}
