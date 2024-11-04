import 'package:dartz/dartz.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/domain/entities/task.dart' as task;

abstract class TaskRepository {
  Future<Either<Failure, List<task.Task>>> getAllTasks();

  Future<Either<Failure, bool>> addTask({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, bool>> updateTask({
    required String id,
    required bool isCompleted,
  });

  Future<Either<Failure, bool>> deleteTask({
    required String id,
  });
}
