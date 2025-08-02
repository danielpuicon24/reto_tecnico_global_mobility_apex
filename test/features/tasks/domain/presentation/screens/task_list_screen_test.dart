import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:reto_tecnico_apex/config/theme/app_colors.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/entities/task.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/providers.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/task_controller.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/screens/task/task_list_screen.dart';

import '../providers/mocks.mocks.dart';



Color getExpectedColorForPriority(String priority) {
  switch (priority) {
    case 'Alta':
      return AppColors.primary;
    case 'Media':
      return AppColors.medium;
    case 'Baja':
      return AppColors.facebook;
    default:
      throw Exception('Unknown priority: $priority');
  }
}



void main() {
  late MockGetAllTasksUseCase mockGetAllTasks;
  late MockSaveTaskUseCase mockSaveTask;
  late MockUpdateTaskUseCase mockUpdateTask;
  late MockDeletedTaskUseCase mockDeletedTask;
  late MockCompleteTaskUseCase mockCompleteTask;

  setUp(() {
    mockGetAllTasks = MockGetAllTasksUseCase();
    mockSaveTask = MockSaveTaskUseCase();
    mockUpdateTask = MockUpdateTaskUseCase();
    mockDeletedTask = MockDeletedTaskUseCase();
    mockCompleteTask = MockCompleteTaskUseCase();
  });

  // Tareas de pruebas
  final fakeTasks = [
    Task(
      id: 1,
      title: 'Test Task',
      description: 'Descripción de prueba',
      isCompleted: false,
      dateTask: '01/08/2025',
      timeTask: '14:00',
      priority: 'Alta',
    ),
    Task(
      id: 2,
      title: 'Test Task 2',
      description: 'Descripción de prueba 2',
      isCompleted: false,
      dateTask: '02/08/2025',
      timeTask: '15:00',
      priority: 'Baja',
    ),
  ];


  testWidgets('greeting and task list title', (WidgetTester tester) async {

    // Devolver tareas al iniciar
    when(mockGetAllTasks()).thenAnswer((_) async => fakeTasks);

    final fakeController = TaskController(
      mockGetAllTasks,
      mockCompleteTask,
      mockSaveTask,
      mockUpdateTask,
      mockDeletedTask,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskControllerProvider.overrideWith((ref) => fakeController),
        ],
        child: const MaterialApp(
          home: TaskScreen(),
        ),
      ),
    );

    // Esperar a que se renderice
    await tester.pumpAndSettle();

    // Assert
    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is RichText &&
            widget.text.toPlainText().contains("Hola, \nBienvenido"),
      ),
      findsOneWidget,
    );
    expect(find.textContaining('Lista de Tareas'), findsOneWidget);
  });

  testWidgets('should display greeting and task list when tasks are loaded', (tester) async {

    // Devolver tareas al iniciar
    when(mockGetAllTasks()).thenAnswer((_) async => fakeTasks);

    final fakeController = TaskController(
      mockGetAllTasks,
      mockCompleteTask,
      mockSaveTask,
      mockUpdateTask,
      mockDeletedTask,
    );

    await tester.pumpWidget(ProviderScope(
      overrides: [
        taskControllerProvider.overrideWith((ref) => fakeController),
      ],
      child: const MaterialApp(
        home: TaskScreen(),
      ),
    ),);

    // Espera que se construya
    await tester.pumpAndSettle();

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Task 2'), findsOneWidget);
    expect(find.text('Descripción de prueba'), findsOneWidget);
    expect(find.text('01/08/2025'), findsOneWidget);
  });

  testWidgets('Should render flag icon with correct color for priority', (tester) async {

    // Devolver tareas al iniciar
    when(mockGetAllTasks()).thenAnswer((_) async => fakeTasks);

    final fakeController = TaskController(
      mockGetAllTasks,
      mockCompleteTask,
      mockSaveTask,
      mockUpdateTask,
      mockDeletedTask,
    );

    await tester.pumpWidget(ProviderScope(
      overrides: [
        taskControllerProvider.overrideWith((ref) => fakeController),
      ],
      child: const MaterialApp(
        home: TaskScreen(),
      ),
    ),);

    // Act
    final flagIcons = find.byIcon(Icons.flag).evaluate().map((e) => e.widget).whereType<Icon>().toList();

    expect(flagIcons.length, fakeTasks.length);

    final expectedColor = getExpectedColorForPriority('Baja');

    final icon = flagIcons.firstWhere(
          (icon) => icon.color == expectedColor,
      orElse: () => throw Exception('No flag icon with expected color found'),
    );

    expect(icon.color, expectedColor);
  });



}

