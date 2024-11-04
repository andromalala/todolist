import 'package:dartz/dartz.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/core/usecases/usecase.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';
import 'package:to_do_list/app/domain/entities/task.dart' as task;

class GetAllTaskUseCase extends UseCase<List<task.Task>, NoParams> {
  final TaskRepository repository;

  GetAllTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, List<task.Task>>> call(NoParams params) async {
    return await repository.getAllTasks();
  }
}
