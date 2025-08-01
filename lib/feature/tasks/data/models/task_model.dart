import 'package:intl/intl.dart';

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
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);
    final formattedTime = DateFormat('hh:mm a').format(now);
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: 'Project from API',
      priority: 'Baja',
      dateTask: formattedDate,
      timeTask: formattedTime,
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
