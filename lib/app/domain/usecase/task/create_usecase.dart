import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/core/usecases/usecase.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';
import 'package:to_do_list/app/domain/entities/task.dart' as tsk;

class CreateTaskUseCase extends UseCase<bool, CreateTaskParams> {
  final TaskRepository repository;

  CreateTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CreateTaskParams params) async {
    return await repository.addTask(data: params.data);
  }
}

class CreateTaskParams extends Equatable {
  final Map<String, dynamic> data;

  const CreateTaskParams({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
