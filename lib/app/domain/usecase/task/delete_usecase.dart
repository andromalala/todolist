import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/core/usecases/usecase.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';

class DeleteTaskUseCase extends UseCase<bool, DeleteTaskParams> {
  final TaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(DeleteTaskParams params) async {
    return await repository.deleteTask(id: params.id);
  }
}

class DeleteTaskParams extends Equatable {
  final String id;

  const DeleteTaskParams({required this.id});

  @override
  List<Object?> get props => [id];
}
