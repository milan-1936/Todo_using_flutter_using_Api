class Todo {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  Todo({
    this.id = 1,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
