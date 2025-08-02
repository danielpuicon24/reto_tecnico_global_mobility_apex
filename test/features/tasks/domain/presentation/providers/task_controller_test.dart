import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/entities/task.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/task_controller.dart';
import 'mocks.mocks.dart';

void main() {
  late MockGetAllTasksUseCase mockGetAllTasks;
  late MockSaveTaskUseCase mockSaveTask;
  late MockUpdateTaskUseCase mockUpdateTask;
  late MockDeletedTaskUseCase mockDeletedTask;
  late MockCompleteTaskUseCase mockCompleteTask;
  late TaskController controller;

  setUp(() {
    mockGetAllTasks = MockGetAllTasksUseCase();
    mockSaveTask = MockSaveTaskUseCase();
    mockUpdateTask = MockUpdateTaskUseCase();
    mockDeletedTask = MockDeletedTaskUseCase();
    mockCompleteTask = MockCompleteTaskUseCase();

    when(mockGetAllTasks()).thenAnswer((_) async => []);

    controller = TaskController(
      mockGetAllTasks,
      mockCompleteTask,
      mockSaveTask,
      mockUpdateTask,
      mockDeletedTask,
    );
  });

  test('You should not save an invalid task', () async {
    final invalidTask = Task(
      title: '',
      description: '',
      dateTask: '',
      timeTask: '',
      priority: '',
      isCompleted: false,
      id: 1,
    );

    final result = await controller.saveNewTask(invalidTask);

    expect(result, false);
    verifyNever(mockSaveTask.call(any));
  });

  test('You must save a valid task', () async {
    final task = Task(
      id: 1,
      title: 'Test Task',
      description: 'Description Task',
      priority: 'Alta',
      dateTask: '01/08/2025',
      timeTask: '10:00 AM',
      isCompleted: false,
    );

    when(mockSaveTask.call(any)).thenAnswer((_) async => true);

    final result = await controller.saveNewTask(task);

    expect(result, true);
    verify(mockSaveTask.call(task)).called(1);
  });

  test('You must update a task correctly', () async {
    final taskToUpdate = Task(
      id: 1,
      title: 'Updated',
      description: 'Updated description',
      priority: 'Alta',
      dateTask: '01/08/2025',
      timeTask: '03:00 PM',
      isCompleted: false,
    );

    when(mockUpdateTask(taskToUpdate)).thenAnswer((_) async => true);

    final result = await controller.updateTask(taskToUpdate);

    expect(result, true);
    verify(mockUpdateTask(taskToUpdate)).called(1);
  });

  test('You must delete a task correctly by ID', () async {
    const taskId = 1;

    when(mockDeletedTask(taskId)).thenAnswer((_) async => true);

    when(mockDeletedTask(taskId)).thenAnswer((_) async => Future.value());

    await controller.deleteTaskById(taskId);
    verify(mockDeletedTask(taskId)).called(1);
  });

  test('You must complete one task correctly by ID', () async {
    final taskToComplete= Task(
      id: 1,
      title: 'Actualizada',
      description: 'Descripción actualizada',
      priority: 'Alta',
      dateTask: '01/08/2025',
      timeTask: '03:00 PM',
      isCompleted: false,
    );

    when(mockCompleteTask(taskToComplete)).thenAnswer((_) async => Future.value());

    await controller.completeTaskById(taskToComplete);
    verify(mockCompleteTask(taskToComplete)).called(1);
  });

}
