import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> saveTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> completedTask(Task task);
  Future<void> deleteTask(int id);
}
