import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/services/services_cache.dart';
import '../../domain/entities/task.dart';
import '../models/task_model.dart';

abstract class TaskDatasource {
  Future<List<Task>> getTasks();
  Future<List<TaskModel>> getRemoteTasks();
  Future<void> insertTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> completeTask(Task task);
  Future<void> deleteTask(int id);
}

class TaskDatasourceImpl implements TaskDatasource {
  final Dio dio;
  final CacheService cache;
  Logger logger = Logger('TaskDatasourceImpl');
  TaskDatasourceImpl(this.dio, this.cache);

  @override
  Future<List<TaskModel>> getRemoteTasks() async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    const ttl = Duration(minutes: 10);
    await cache.openBox(boxName);

    final lastSync = cache.get(boxName, 'last_sync') as DateTime?;
    final isStale = lastSync == null || DateTime.now().difference(lastSync) > ttl;

    if (!isStale) {
      final cachedData = cache.get(boxName, cacheKey);
      if (cachedData != null) {
        return (cachedData as List)
            .map((e) => TaskModel.fromJsonAPI(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

    final response = await dio.get(
      '/todos',
      options: Options(headers: {'Accept': 'application/json'}),
    );
    logger.info('getRemoteTasks ${response.data}');

    if (response.statusCode == 200) {
      final List data = response.data;

      final tasks = data.map((json) => TaskModel.fromJsonAPI(json)).toList();

      await cache.put(
        boxName,
        cacheKey,
        tasks.map((e) => e.toJson()).toList(),
      );
      await cache.put(boxName, 'last_sync', DateTime.now());

      return tasks;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  @override
  Future<void> completeTask(Task task) async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    await cache.openBox(boxName);

    final taskList = cache.get(boxName, cacheKey) as List?;
    if (taskList != null) {
      final index = taskList.indexWhere((e) => e['id'] == task.id);
      if (index != -1) {
        final updatedTask = Map<String, dynamic>.from(taskList[index]);
        updatedTask['completed'] = true;

        taskList[index] = updatedTask;

        await cache.put(boxName, cacheKey, taskList);
      }
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    await cache.openBox(boxName);

    final cachedData = cache.get(boxName, cacheKey);
    if (cachedData != null) {
      final tasks = (cachedData as List)
          .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      tasks.removeWhere((task) => task.id == id);

      await cache.put(boxName, cacheKey, tasks.map((e) => e.toJson()).toList());
    }
  }

  @override
  Future<void> insertTask(Task task) async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    await cache.openBox(boxName);

    final cachedData = cache.get(boxName, cacheKey);

    List<TaskModel> currentTasks = [];

    if (cachedData != null) {
      currentTasks = (cachedData as List)
          .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    final lastId = currentTasks.isNotEmpty
        ? currentTasks.map((t) => t.id).reduce((a, b) => a > b ? a : b)
        : 0;

    final newTask = TaskModel(
      id: lastId + 1,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      priority: task.priority,
      dateTask: task.dateTask,
      timeTask: task.timeTask,
    );

    currentTasks.add(newTask);

    await cache.put(boxName, cacheKey, currentTasks.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> updateTask(Task task) async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    await cache.openBox(boxName);

    final cachedData = cache.get(boxName, cacheKey);

    if (cachedData != null) {
      final currentTasks = (cachedData as List)
          .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      final updatedTasks = currentTasks.map((t) {
        if (t.id == task.id) {
          return TaskModel(
            id: t.id,
            title: task.title,
            description: task.description,
            priority: task.priority,
            dateTask: task.dateTask,
            timeTask: task.timeTask,
            isCompleted: task.isCompleted,
          );
        }
        return t;
      }).toList();


      await cache.put(boxName, cacheKey, updatedTasks.map((e) => e.toJson()).toList());
    } else {
      throw Exception('No se encontró la lista de tareas en caché.');
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    const boxName = Keys.tasks;
    const cacheKey = 'list_tasks';
    await cache.openBox(boxName);
    final cachedData = cache.get(boxName, cacheKey);
    return cachedData != null
        ? (cachedData as List)
        .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
        .toList()
        : [];
  }
}

