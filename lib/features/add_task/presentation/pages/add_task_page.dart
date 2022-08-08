import 'package:flutter/material.dart';
import 'package:test1/features/add_task/presentation/widgets/add_task_widget.dart';
import 'package:test1/features/home/presentation/widgets/home_widget.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
        ),
      ),
      body: const AddTaskWidget(),
    );
  }
}
