import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/core/usecases/usecase.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';

class UpdateTaskUseCase extends UseCase<bool, UpdateTaskParams> {
  final TaskRepository repository;

  UpdateTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(UpdateTaskParams params) async {
    return await repository.updateTask(
      id: params.id,
      isCompleted: params.isCompleted,
    );
  }
}

class UpdateTaskParams extends Equatable {
  final String id;
  final bool isCompleted;

  const UpdateTaskParams({required this.id, required this.isCompleted});

  @override
  List<Object?> get props => [id, isCompleted];
}
