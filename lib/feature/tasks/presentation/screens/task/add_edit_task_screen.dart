import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reto_tecnico_apex/config/theme/app_colors.dart';
import '../../../../../config/router/router.dart';
import '../../../domain/entities/task.dart';
import '../../providers/providers.dart';
import '../../providers/task_controller.dart';
import '../../widgets/input_edit_text_widget.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  final bool isNew;
  final Task? task;

  const AddEditTaskScreen({super.key, required this.isNew, this.task});

  @override
  ConsumerState<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends ConsumerState<AddEditTaskScreen> {
  late TextEditingController taskDescriptiontController;
  late TextEditingController taskTitleController;
  late TextEditingController taskDateController;
  late TextEditingController taskTimeController;
  late TextEditingController priorityController;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    taskTitleController = TextEditingController(text: task?.title ?? '');
    taskDescriptiontController = TextEditingController(
      text: task?.description ?? '',
    );
    taskDateController = TextEditingController(text: task?.dateTask ?? '');
    taskTimeController = TextEditingController(text: task?.timeTask ?? '');
    priorityController = TextEditingController(text: task?.priority ?? '');

    if (!widget.isNew && task != null) {
      Future.microtask(() {
        ref
            .read(taskControllerProvider.notifier)
            .setPriorityOption(task.priority!);
      });
    } else {
      Future.microtask(() {
        ref.read(taskControllerProvider.notifier).setPriorityOption('Baja');
      });
    }
  }

  @override
  void dispose() {
    taskDescriptiontController.dispose();
    taskTitleController.dispose();
    taskDateController.dispose();
    taskTimeController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final String hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    final taskController = ref.read(taskControllerProvider.notifier);
    final state = ref.watch(taskControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height / 10,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                ref
                    .read(taskControllerProvider.notifier)
                    .applyFilter(FilterOption.all);
                context.pop();
              },
              child: Container(
                width: width / 7,
                height: height / 18,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.isNew ? "Agregar Tarea" : "Editar Tarea",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputEditTextWidget(
                  title: "Titulo del Proyecto",
                  icon: Icons.edit,
                  textController: taskTitleController,
                ),
                InputEditTextWidget(
                  title: "Descripcion de la Tarea",
                  icon: Icons.task,
                  textController: taskDescriptiontController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputEditTextWidget(
                        title: "Fecha",
                        icon: Icons.date_range_outlined,
                        textController: taskDateController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget? child) {
                              return child!;
                            },
                          );
                          if (pickedDate != null) {
                            String formattedDate = DateFormat(
                              'dd/MM/yyyy',
                            ).format(pickedDate);
                            taskDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InputEditTextWidget(
                        title: "Horario",
                        icon: Icons.access_time,
                        textController: taskTimeController,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return child!;
                            },
                          );
                          if (pickedTime != null) {
                            final String formattedTime = _formatTimeOfDay(
                              pickedTime,
                            );
                            taskTimeController.text = formattedTime;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Prioridad",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => taskController.setPriorityOption("Alta"),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: state.selectedPriority == "Alta"
                                ? AppColors.primary
                                : AppColors.white,
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag,
                                color: state.selectedPriority == "Alta"
                                    ? AppColors.white
                                    : AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Alta",
                                style: state.selectedPriority == "Alta"
                                    ? Theme.of(context).textTheme.headlineSmall
                                          ?.copyWith(color: AppColors.white)
                                    : Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () => taskController.setPriorityOption("Media"),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: state.selectedPriority == "Media"
                                ? AppColors.medium
                                : AppColors.white,
                            border: Border.all(color: AppColors.medium),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag,
                                color: state.selectedPriority == "Media"
                                    ? AppColors.white
                                    : AppColors.medium,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Media",
                                style: state.selectedPriority == "Media"
                                    ? Theme.of(context).textTheme.headlineSmall
                                          ?.copyWith(color: AppColors.white)
                                    : Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () => taskController.setPriorityOption("Baja"),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: state.selectedPriority == "Baja"
                                ? AppColors.facebook
                                : AppColors.white,
                            border: Border.all(color: AppColors.facebook),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag,
                                color: state.selectedPriority == "Baja"
                                    ? AppColors.white
                                    : AppColors.facebook,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Baja",
                                style: state.selectedPriority == "Baja"
                                    ? Theme.of(context).textTheme.headlineSmall
                                          ?.copyWith(color: AppColors.white)
                                    : Theme.of(context).textTheme.headlineSmall,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  final task = Task(
                    id: widget.isNew
                        ? DateTime.now().millisecondsSinceEpoch
                        : widget.task!.id,
                    title: taskTitleController.text,
                    description: taskDescriptiontController.text,
                    priority: state.selectedPriority,
                    dateTask: taskDateController.text,
                    timeTask: taskTimeController.text,
                    isCompleted: widget.task?.isCompleted ?? false,
                  );

                  final success = widget.isNew
                      ? await taskController.saveNewTask(task)
                      : await taskController.updateTask(task);

                  debugPrint('success : $success');
                  if (success) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.isNew ? 'Tarea guardada' : 'Tarea actualizada',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                    ref
                        .read(taskControllerProvider.notifier)
                        .applyFilter(FilterOption.all);
                    GoRouter.of(context).push(Routes.listTasks);
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Todos los campos son obligatorios.',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        backgroundColor: AppColors.medium,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      "Guardar datos",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
