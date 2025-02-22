import 'package:flutter/foundation.dart';
import '../models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  // ※ 実際の永続化実装例として、SharedPreferencesへの保存/読み込みも検討

  List<Task> get tasks => _tasks;

  TaskProvider() {
    // アプリ起動時にタスクのロードと「Done」状態のチェックを行う
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      // JSON文字列からデコードしてTaskリストを復元
      final List<dynamic> decoded = jsonDecode(tasksString);
      _tasks = decoded.map((json) => Task(
        title: json['title'],
        doneDates: List<String>.from(json['doneDates']),
      )).toList();
    }
    // 毎日0時リセットの判定は、トップ画面側で「今日の日付が登録されているか」で判断
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_tasks.map((task) => {
      'title': task.title,
      'doneDates': task.doneDates,
    }).toList());
    prefs.setString('tasks', encoded);
  }

  void addTask(String title) {
    if (_tasks.length >= 10) return; // 最大10件まで
    _tasks.add(Task(title: title));
    saveTasks();
    notifyListeners();
  }

  void markTaskDone(Task task) {
    final today = DateTime.now();
    final dateStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    // そのタスクが今日既にDone済みでなければ追加
    if (!task.doneDates.contains(dateStr)) {
      task.doneDates.add(dateStr);
      saveTasks();
      notifyListeners();
    }
  }
}
