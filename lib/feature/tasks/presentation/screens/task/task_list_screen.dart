import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reto_tecnico_apex/config/theme/app_colors.dart';
import 'package:reto_tecnico_apex/feature/tasks/presentation/providers/task_controller.dart';
import '../../../../../config/router/router.dart';
import '../../../domain/entities/task.dart';
import '../../providers/providers.dart';
import 'ad_edit_task_arguments.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskControllerProvider);
    final selectedFilter = taskState.selectedFilter;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Hola, \n",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      TextSpan(
                        text: "Bienvenido",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).push(
                          Routes.addEditTask,
                          extra: AddEditTaskArguments(isNew: true),
                        );
                      },
                      child: SizedBox(
                        height: height * 0.05,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    SizedBox(
                      height: height * 0.05,
                      child: InkWell(
                        onTap: ()=> GoRouter.of(context).push(Routes.listCountries),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.travel_explore,
                                color: AppColors.background,
                                size: 25.0,
                              ),
                              Positioned(
                                top: 2,
                                right: 6,
                                child: Container(
                                  height: 9,
                                  width: 9,
                                  decoration: const BoxDecoration(
                                    color: AppColors.background,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 2,
              children: [
                Container(
                  width: width * 0.08,
                  height: height * 0.06,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Icon(Icons.filter_list_rounded, size: 18.0),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(taskControllerProvider.notifier)
                                .applyFilter(FilterOption.all);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 3.0,
                              bottom: 3.0,
                              right: 2.0,
                            ),
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: selectedFilter == FilterOption.all
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Todos",
                                    textAlign: TextAlign.center,
                                    style: selectedFilter == FilterOption.all
                                        ? Theme.of(
                                            context,
                                          ).textTheme.headlineSmall?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 12,
                                          )
                                        : Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(fontSize: 12),
                                  ),
                                ),
                                Container(
                                  width: width * 0.12,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedFilter == FilterOption.all
                                        ? AppColors.white
                                        : AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      taskState.totalTasks.toString(),
                                      style: selectedFilter == FilterOption.all
                                          ? Theme.of(
                                              context,
                                            ).textTheme.headlineSmall
                                          : Theme.of(
                                              context,
                                            ).textTheme.headlineSmall?.copyWith(
                                              color: AppColors.white,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(taskControllerProvider.notifier)
                                .applyFilter(FilterOption.pending);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 3.0,
                              bottom: 3.0,
                              right: 2.0,
                            ),
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: selectedFilter == FilterOption.pending
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Pendientes",
                                    textAlign: TextAlign.center,
                                    style:
                                        selectedFilter == FilterOption.pending
                                        ? Theme.of(
                                            context,
                                          ).textTheme.headlineSmall?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 11,
                                          )
                                        : Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  width: width * 0.12,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        selectedFilter == FilterOption.pending
                                        ? AppColors.white
                                        : AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      taskState.pendingTasks.toString(),
                                      style:
                                          selectedFilter == FilterOption.pending
                                          ? Theme.of(
                                              context,
                                            ).textTheme.headlineSmall
                                          : Theme.of(
                                              context,
                                            ).textTheme.headlineSmall?.copyWith(
                                              color: AppColors.white,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(taskControllerProvider.notifier)
                                .applyFilter(FilterOption.completed);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 3.0,
                              bottom: 3.0,
                              right: 2.0,
                            ),
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: selectedFilter == FilterOption.completed
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Terminados",
                                    textAlign: TextAlign.center,
                                    style:
                                        selectedFilter == FilterOption.completed
                                        ? Theme.of(
                                            context,
                                          ).textTheme.headlineSmall?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 11,
                                          )
                                        : Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  width: width * 0.12,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        selectedFilter == FilterOption.completed
                                        ? AppColors.white
                                        : AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      taskState.completedTasks.toString(),
                                      style:
                                          selectedFilter ==
                                              FilterOption.completed
                                          ? Theme.of(
                                              context,
                                            ).textTheme.headlineSmall
                                          : Theme.of(
                                              context,
                                            ).textTheme.headlineSmall?.copyWith(
                                              color: AppColors.white,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/img/daniel.jpg'),
                    radius: 25,
                  ),
                  Expanded(
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: taskState.completedPercentage / 100,
                      center: Text(
                        "Progreso del trabajo: ${taskState.completedPercentage.toStringAsFixed(1)}%",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                      barRadius: const Radius.circular(10),
                      progressColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Lista de Tareas",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: taskState.tasks.length,
                itemBuilder: (context, index) {
                  final sortedTasks = List<Task>.from(taskState.tasks)
                    ..sort((a, b) => b.id.compareTo(a.id));
                  final task = sortedTasks[index];
                  return Dismissible(
                    background: stackBehindDismiss(context, task),
                    secondaryBackground: secondarystackBehindDismiss(
                      context,
                      task,
                    ),
                    key: ObjectKey(task),
                    child: GestureDetector(
                      onTap: () {
                        if (!task.isCompleted) {
                          GoRouter.of(context).push(
                            Routes.addEditTask,
                            extra: AddEditTaskArguments(
                              isNew: false,
                              task: task,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                task.title,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineLarge,
                                              ),
                                            ),
                                            task.isCompleted
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: AppColors.primary,
                                                  )
                                                : const Text(''),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.015),
                                        Text(
                                          task.description!,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  iconPriority(context, task.priority!),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.access_time),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        task.timeTask!,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            task.dateTask!,
                                            textAlign: TextAlign.right,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.02),
                                        const Icon(Icons.date_range_outlined),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      if (!task.isCompleted) {
                        if (direction == DismissDirection.startToEnd) {
                          ref
                              .read(taskControllerProvider.notifier)
                              .completeTaskById(task);
                        } else if (direction == DismissDirection.endToStart) {
                          ref
                              .read(taskControllerProvider.notifier)
                              .deleteTaskById(task.id);
                        }
                      }
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      if (!task.isCompleted) {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "ELIMINAR",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                content: Text(
                                  "Estás seguro de que deseas eliminar esta tarea?",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text(
                                      "ELIMINAR",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      "CANCELAR",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "FINALIZAR",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                content: Text(
                                  "Estas seguro que quieres completar la tarea?",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text(
                                      "FINALIZAR",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      "CANCELAR",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget secondarystackBehindDismiss(BuildContext context, Task task) {
  if (!task.isCompleted) {
    return Container(
      color: AppColors.medium,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Eliminar',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.delete_forever_rounded, color: AppColors.white),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget stackBehindDismiss(BuildContext context, Task task) {
  if (!task.isCompleted) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              'Finalizar',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, color: AppColors.white),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget iconPriority(BuildContext context, String priority) {
  if (priority == "Alta") {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(Icons.flag, color: Theme.of(context).primaryColor),
      ),
    );
  } else if (priority == "Media") {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(Icons.flag, color: AppColors.medium),
      ),
    );
  } else {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(Icons.flag, color: AppColors.facebook),
      ),
    );
  }
}
