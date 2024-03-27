import 'package:flutter/material.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback onTap;

  TaskTile({required this.task, this.onChanged, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Checkbox(
        value: task.isDone,
        onChanged: onChanged,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}