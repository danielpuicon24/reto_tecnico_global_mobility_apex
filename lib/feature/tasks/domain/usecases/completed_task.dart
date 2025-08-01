import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CompleteTask {
  final TaskRepository repository;

  CompleteTask(this.repository);

  Future<void> call(Task task) async {
    final completedTask = task.copyWith(isCompleted: true);
    await repository.completedTask(completedTask);
  }
}
