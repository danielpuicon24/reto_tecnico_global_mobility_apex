import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_tecnico_apex/core/services/services_cache.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/deleted_task.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/update_task.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/save_task.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/task_controller.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasource/task_datasource.dart';
import '../../data/repository_impl/task_repository_impl.dart';
import '../../domain/usecases/completed_task.dart';
import '../../domain/usecases/get_all_tasks.dart';

final cache = CacheService();

final taskControllerProvider =
StateNotifierProvider<TaskController, TaskState>((ref) {
  final getAllTasks = ref.watch(getAllTasksProvider);
  final getCompletedTasks = ref.watch(getCompletedTasksProvider);
  final getSaveTask = ref.watch(getSaveTaskProvider);
  final getUpdateTask = ref.watch(getUpdateTaskProvider);
  final getDeleteTask = ref.watch(getDeleteTaskProvider);
  return TaskController(getAllTasks, getCompletedTasks, getSaveTask, getUpdateTask, getDeleteTask);
});

final getAllTasksProvider = Provider<GetAllTasks>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetAllTasks(repository);
});

final getCompletedTasksProvider = Provider<CompleteTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return CompleteTask(repository);
});

final getSaveTaskProvider = Provider<SaveTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return SaveTask(repository);
});

final getUpdateTaskProvider = Provider<UpdateTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTask(repository);
});

final getDeleteTaskProvider = Provider<DeletedTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeletedTask(repository);
});

final taskRepositoryProvider = Provider((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});

final taskDatasourceProvider = Provider((ref) {
  return TaskDatasourceImpl(DioClient.dio, cache);
});
