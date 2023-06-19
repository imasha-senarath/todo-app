class Task {
  final int? id;
  final String title;
  final String description;

  const Task({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description
     };
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description}';
  }
}
