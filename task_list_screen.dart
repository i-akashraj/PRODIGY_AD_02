import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_detail_screen.dart';
import 'task_provider.dart';
import 'task.dart';
import 'task_tile.dart';
class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              Task task = taskProvider.tasks[index];
              return TaskTile(
                task: task,
                onChanged: (value) {
                  task.isDone = value!;
                  taskProvider.updateTask(task);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(),
            ),
          );
        },
        child: Icon(Icons.add_box_outlined,),
      ),
    );
  }
}