import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_tecnico_apex/core/services/services_cache.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/deleted_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/update_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/save_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/task_controller.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasource/task_datasource.dart';
import '../../data/repository_impl/task_repository_impl.dart';
import '../../domain/usecases/completed_task_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart';

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

final getAllTasksProvider = Provider<GetAllTasksUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetAllTasksUseCase(repository);
});

final getCompletedTasksProvider = Provider<CompleteTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return CompleteTaskUseCase(repository);
});

final getSaveTaskProvider = Provider<SaveTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return SaveTaskUseCase(repository);
});

final getUpdateTaskProvider = Provider<UpdateTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(repository);
});

final getDeleteTaskProvider = Provider<DeletedTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeletedTaskUseCase(repository);
});

final taskRepositoryProvider = Provider((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});

final taskDatasourceProvider = Provider((ref) {
  return TaskDatasourceImpl(DioClient.dio, cache);
});
