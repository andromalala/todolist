import 'package:dartz/dartz.dart';
import 'package:to_do_list/app/core/errors/exceptions.dart';
import 'package:to_do_list/app/core/errors/failure.dart';
import 'package:to_do_list/app/core/network/network_info.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';

import '../sources/remote/remote_source.dart';
import 'package:to_do_list/app/domain/entities/task.dart' as task;

class TaskRepositoryImpl implements TaskRepository {
  final RemoteSource remoteDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> addTask({
    required Map<String, dynamic> data,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.addTask(data: data);
        return Right(remoteData);
      } on ServerException catch (_) {
        return Left(ServerFailure(
          message: _.message,
          statusCode: _.statusCode,
          body: _.body,
        ));
      } on SocketException catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      } catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.deleteTask(id: id);
        return Right(remoteData);
      } on ServerException catch (_) {
        return Left(ServerFailure(
          message: _.message,
          statusCode: _.statusCode,
          body: _.body,
        ));
      } on SocketException catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      } catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<task.Task>>> getAllTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllTasks();
        return Right(remoteData);
      } on ServerException catch (_) {
        return Left(ServerFailure(
          message: _.message,
          statusCode: _.statusCode,
          body: _.body,
        ));
      } on SocketException catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      } catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateTask(
      {required String id, required bool isCompleted}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.updateTask(
          id: id,
          isCompleted: isCompleted,
        );
        return Right(remoteData);
      } on ServerException catch (_) {
        return Left(ServerFailure(
          message: _.message,
          statusCode: _.statusCode,
          body: _.body,
        ));
      } on SocketException catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      } catch (_) {
        return Left(ServerFailure(
          message: _.toString(),
          body: '',
          statusCode: 0,
        ));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
