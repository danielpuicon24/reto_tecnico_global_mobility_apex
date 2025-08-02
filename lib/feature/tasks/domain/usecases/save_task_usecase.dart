import '../entities/task.dart';
import '../repositories/task_repository.dart';

class SaveTaskUseCase {
  final TaskRepository repository;

  SaveTaskUseCase(this.repository);

  Future<void> call(Task task) => repository.saveTask(task);
}