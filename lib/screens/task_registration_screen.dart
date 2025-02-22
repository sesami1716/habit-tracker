import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskRegistrationScreen extends StatefulWidget {
  const TaskRegistrationScreen({super.key});

  @override
  _TaskRegistrationScreenState createState() => _TaskRegistrationScreenState();
}

class _TaskRegistrationScreenState extends State<TaskRegistrationScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('タスク登録')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'タスク名',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  taskProvider.addTask(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
