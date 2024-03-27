import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;

  TaskDetailScreen({this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TaskProvider _taskProvider;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title);
    _descriptionController = TextEditingController(text: widget.task?.description);
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (widget.task == null) {
                  Task newTask = Task(id: DateTime.now().toString(),
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  _taskProvider.addTask(newTask);
                } else {
                  Task updatedTask = Task(
                    id: widget.task!.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    isDone: widget.task!.isDone,
                  );
                  _taskProvider.updateTask(updatedTask);
                }
                Navigator.pop(context);
              },
              child: Text(widget.task == null ? 'Add' : 'Save'),
            ),
            if (widget.task != null)
              ElevatedButton(
                onPressed: () {
                  _taskProvider.deleteTask(widget.task!.id);
                  Navigator.pop(context);
                },
                child: Text('Delete'),
              ),
          ],
        ),
      ),
    );
  }
}