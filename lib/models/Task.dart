class Task {
  int? id;
  String content;
  bool completed;
  String? title;

  Task({
    required this.completed,
    required this.content,
    this.id,
    this.title,
  });
}
