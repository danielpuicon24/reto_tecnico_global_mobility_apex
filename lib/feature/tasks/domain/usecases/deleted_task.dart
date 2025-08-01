import '../repositories/task_repository.dart';

class DeletedTask {
  final TaskRepository repository;

  DeletedTask(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
