class Task {
  String title;
  // Doneした日付を 'yyyy-MM-dd' 形式の文字列として管理
  List<String> doneDates;

  Task({required this.title, List<String>? doneDates})
      : doneDates = doneDates ?? [];

}