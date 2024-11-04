import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:to_do_list/app/core/network/network_info.dart';
import 'package:to_do_list/app/data/repositories/task_repository_impl.dart';
import 'package:to_do_list/app/data/sources/remote/remote_source.dart';
import 'package:to_do_list/app/data/sources/remote/remote_source_impl.dart';
import 'package:to_do_list/app/domain/repositories/task/task_repository.dart';
import 'package:to_do_list/app/domain/usecase/task/create_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/delete_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/read_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/update_usecase.dart';
import 'package:to_do_list/app/presentation/pages/home/bloc/task_bloc.dart';
import 'package:to_do_list/app/core/http/http_client.dart';

final GetIt sl = GetIt.instance; //sl is referred to as Service Locator

///Dependency injection
Future<void> init() async {
  ///Blocs

  sl.registerFactory(() => TaskBloc(
      createTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
      getAllTaskUseCase: sl(),
      updateTaskUseCase: sl()));

  ///Use cases
  sl.registerLazySingleton(() => UpdateTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(repository: sl()));

  ///Repositories
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  ///Data sources
  sl.registerLazySingleton<RemoteSource>(() => RemoteSourceImpl(client: sl()));

  ///Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<HttpClient>(() => HttpClient());
}
