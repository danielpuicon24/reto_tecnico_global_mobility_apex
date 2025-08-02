import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CompleteTaskUseCase {
  final TaskRepository repository;

  CompleteTaskUseCase(this.repository);

  Future<void> call(Task task) async {
    final completedTask = task.copyWith(isCompleted: true);
    await repository.completedTask(completedTask);
  }
}
