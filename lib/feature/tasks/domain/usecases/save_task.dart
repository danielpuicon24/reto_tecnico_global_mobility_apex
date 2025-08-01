import '../entities/task.dart';
import '../repositories/task_repository.dart';

class SaveTask {
  final TaskRepository repository;

  SaveTask(this.repository);

  Future<void> call(Task task) => repository.saveTask(task);
}