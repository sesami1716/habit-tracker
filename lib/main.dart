import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/top_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初期化処理（SharedPreferencesの読み込みなど）があればここで実施
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopScreen(),
      // 必要に応じてroutesも設定可能
    );
  }
}
