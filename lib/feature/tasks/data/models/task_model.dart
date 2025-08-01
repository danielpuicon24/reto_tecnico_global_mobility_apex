import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    super.description,
    required super.title,
    super.priority,
    super.dateTask,
    super.timeTask,
    required super.isCompleted,
  });

  factory TaskModel.fromJsonAPI(Map<String, dynamic> json) {
    final now = DateTime.now();
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: 'Project from API',
      priority: 'Baja',
      dateTask: now.toIso8601String().split('T').first,
      timeTask: now.toIso8601String().split('T').last.substring(0, 5),
      isCompleted: json['completed'] ?? false,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      dateTask: json['dateTask'] ?? '',
      timeTask: json['timeTask'] ?? '',
      isCompleted: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'title': title,
    'priority': priority,
    'dateTask': dateTask,
    'timeTask': timeTask,
    'completed': isCompleted,
  };
}
