import '../../../../core/services/services_cache.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasource/task_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;

  TaskRepositoryImpl(this.datasource);

  final cache = CacheService();

  @override
  Future<List<Task>> getAllTasks({bool forceRefresh = false}) async {
    final localTasks = await datasource.getTasks();

    if (localTasks.isNotEmpty && !forceRefresh) {
      return localTasks;
    }

    final remoteTasks = await datasource.getRemoteTasks();

    return remoteTasks;
  }

  @override
  Future<void> saveTask(Task task) => datasource.insertTask(task);

  @override
  Future<void> updateTask(Task task) => datasource.updateTask(task);


  @override
  Future<void> completedTask(Task task) => datasource.completeTask(task);

  @override
  Future<void> deleteTask(int id) => datasource.deleteTask(id);

}
