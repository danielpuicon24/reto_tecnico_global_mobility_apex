import '../repositories/task_repository.dart';

class DeletedTaskUseCase {
  final TaskRepository repository;

  DeletedTaskUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
