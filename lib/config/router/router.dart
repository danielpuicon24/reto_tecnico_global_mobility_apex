import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/screens/task/task_list_screen.dart';
import '../../feature/tasks/presentation/screens/task/ad_edit_task_arguments.dart';
import '../../feature/tasks/presentation/screens/task/add_edit_task_screen.dart';

class Routes {
  static const String listTasks = '/listTasks';
  static const String addEditTask = '/addEditTask';
  static const String listCountries = '/listCountries';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: Routes.listTasks,
  navigatorKey: rootNavigatorKey,
  errorBuilder: (context, state) => const TaskScreen(),
  routes: [
    GoRoute(
      path: Routes.listTasks,
      builder: (context, state) => const TaskScreen(),
    ),
    GoRoute(
      path: Routes.addEditTask,
      builder: (context, state) {
        final args = state.extra as AddEditTaskArguments;
        return AddEditTaskScreen(
          isNew: args.isNew,
          task: args.task,
        );
      },
    ),
    GoRoute(
      path: Routes.listCountries,
      builder: (context, state) => const TaskScreen(),
    ),

  ],
);


