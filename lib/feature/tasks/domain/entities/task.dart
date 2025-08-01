class Task {
  final int id;
  final String title;
  final String? description;
  final String? priority;
  final String? dateTask;
  final String? timeTask;
  final bool isCompleted;

  Task(
      {this.description,
      this.priority,
      this.dateTask,
      this.timeTask,
      required this.id,
      required this.title,
      required this.isCompleted,
      });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? priority,
    String? dateTask,
    String? timeTask,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dateTask: dateTask ?? this.dateTask,
      timeTask: timeTask ?? this.timeTask,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
