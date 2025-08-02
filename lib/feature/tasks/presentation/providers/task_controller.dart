import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/completed_task_usecase.dart';
import '../../domain/usecases/deleted_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart';
import '../../domain/usecases/save_task_usecase.dart';

enum FilterOption { all, pending, completed }

class TaskState {
  final List<Task> allTasks;
  final List<Task> tasks;
  final FilterOption selectedFilter;
  final String? selectedPriority;
  final bool isLoading;

  TaskState({
    required this.allTasks,
    required this.tasks,
    this.isLoading = false,
    this.selectedFilter = FilterOption.all,
    this.selectedPriority,
  });

  TaskState copyWith({
    List<Task>? allTasks,
    List<Task>? tasks,
    bool? isLoading,
    FilterOption? selectedFilter,
    String? selectedPriority,
  }) {
    return TaskState(
      allTasks: allTasks ?? this.allTasks,
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedPriority: selectedPriority ?? this.selectedPriority,
    );
  }

  int get totalTasks => allTasks.length;

  int get pendingTasks => allTasks.where((t) => !t.isCompleted).length;

  int get completedTasks => allTasks.where((t) => t.isCompleted).length;

  double get completedPercentage {
    if (tasks.isEmpty) return 0.0;
    return (completedTasks / totalTasks) * 100;
  }
}

class TaskController extends StateNotifier<TaskState> {
  final GetAllTasksUseCase getAllTasks;
  final CompleteTaskUseCase completeTask;
  final SaveTaskUseCase saveTask;
  final UpdateTaskUseCase editTask;
  final DeletedTaskUseCase deletedTask;

  TaskController(
    this.getAllTasks,
    this.completeTask,
    this.saveTask,
    this.editTask,
    this.deletedTask,
  ) : super(TaskState(tasks: [], allTasks: [])) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);
    final result = await getAllTasks();
    state = state.copyWith(tasks: result, isLoading: false, allTasks: result);
  }

  Future<void> applyFilter(FilterOption filter) async {
    final allTasks = await getAllTasks();

    List<Task> filteredTasks;
    switch (filter) {
      case FilterOption.all:
        filteredTasks = allTasks;
        break;
      case FilterOption.pending:
        filteredTasks = allTasks.where((t) => !t.isCompleted).toList();
        break;
      case FilterOption.completed:
        filteredTasks = allTasks.where((t) => t.isCompleted).toList();
        break;
    }

    state = state.copyWith(tasks: filteredTasks, selectedFilter: filter);
  }

  void setPriorityOption(String value) {
    state = state.copyWith(selectedPriority: value);
  }

  bool _isValid(Task task) {
    return task.title.isNotEmpty &&
        task.description!.isNotEmpty &&
        task.dateTask!.isNotEmpty &&
        task.timeTask!.isNotEmpty &&
        task.priority!.isNotEmpty;
  }

  Future<bool> saveNewTask(Task task) async {
    if (!_isValid(task)) return false;
    await saveTask(task);
    await loadTasks();
    return true;
  }

  Future<bool> updateTask(Task task) async {
    if (!_isValid(task)) return false;
    await editTask(task);
    await loadTasks();
    return true;
  }

  Future<void> completeTaskById(Task task) async {
    await completeTask(task);
    await loadTasks();
    await applyFilter(state.selectedFilter);
  }

  Future<void> deleteTaskById(int taskId) async {
    await deletedTask(taskId);
    await loadTasks();
    await applyFilter(state.selectedFilter);
  }

}
