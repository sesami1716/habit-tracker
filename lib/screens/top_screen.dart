import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_registration_screen.dart';
import 'task_calendar_screen.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // タスク登録画面へ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskRegistrationScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          final isDoneToday = task.doneDates.contains(todayStr);
          return ListTile(
            title: Text(task.title),
            trailing: ElevatedButton(
              onPressed: isDoneToday
                  ? null // 既に今日Doneならボタンを無効化
                  : () {
                      taskProvider.markTaskDone(task);
                    },
              child: Text('Done'),
            ),
            onTap: () {
              // タスクのカレンダー画面へ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskCalendarScreen(task: task)),
              );
            },
          );
        },
      ),
    );
  }
}
