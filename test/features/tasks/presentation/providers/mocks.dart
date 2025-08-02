import 'package:mockito/annotations.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/completed_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/deleted_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/save_task_usecase.dart';
import 'package:reto_tecnico_apex/feature/tasks/domain/usecases/update_task_usecase.dart';

@GenerateMocks([
  GetAllTasksUseCase,
  SaveTaskUseCase,
  UpdateTaskUseCase,
  DeletedTaskUseCase,
  CompleteTaskUseCase,
])


void main() {}