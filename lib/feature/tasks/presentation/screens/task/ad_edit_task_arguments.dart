import '../../../domain/entities/task.dart';

class AddEditTaskArguments {
  final bool isNew;
  final Task? task;

  AddEditTaskArguments({required this.isNew, this.task});
}
