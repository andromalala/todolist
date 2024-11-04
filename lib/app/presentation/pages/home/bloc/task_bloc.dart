import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/core/errors/failure.dart';

import 'package:to_do_list/app/core/errors/message.dart';
import 'package:to_do_list/app/core/states/base_state.dart';
import 'package:to_do_list/app/core/states/error_state.dart';
import 'package:to_do_list/app/core/usecases/usecase.dart';
import 'package:to_do_list/app/core/utils/constants.dart';
import 'package:to_do_list/app/domain/entities/task.dart';
import 'package:to_do_list/app/domain/usecase/task/create_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/delete_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/read_usecase.dart';
import 'package:to_do_list/app/domain/usecase/task/update_usecase.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, BaseState> {
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final GetAllTaskUseCase getAllTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskBloc({
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getAllTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(const BaseState(
            status: Status.loginInitial, message: "loginInitial")) {
    on<GetListTaskEvent>(_getListTaskEvent);
    on<AddTaskEvent>(_addTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<UpdateTaskEvent>(_updateTaskEvent);
    on<SortTasksEvent>(_sortTasksEvent);
    on<FilterCompletedTasksEvent>(_filterCompletedTasksEvent);
  }

  TextEditingController titleControllerField = TextEditingController();
  TextEditingController descriptionControllerField = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SortType _currentSortType = SortType.dateNewest;
  List<Task> _tasks = [];
  int selectedIndex = 0;

  List<Task> _sortTasks(List<Task> tasks) {
    switch (_currentSortType) {
      case SortType.dateNewest:
        _tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortType.dateOldest:
        _tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortType.alphabeticalAsc:
        _tasks.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case SortType.alphabeticalDesc:
        _tasks.sort(
            (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
    }
    return tasks;
  }

  Future<void> _getListTaskEvent(GetListTaskEvent event, emit) async {
    emit(const TaskLoadingState(status: Status.loading, message: 'loading...'));
    try {
      final result = await getAllTaskUseCase(NoParams());
      result.fold(
        (failure) {
          if (failure is NoConnectionFailure) {
            emit(const ErrorState(
                status: Status.error, message: noConnexionMessage));
          } else if (failure is ServerFailure) {
            emit(const ErrorState(status: Status.error, message: serverError));
          } else {
            emit(const ErrorState(status: Status.error, message: unknownError));
          }
        },
        (success) {
          _tasks = success;
          _currentSortType = SortType.dateNewest;
          selectedIndex = 0;
          List<Task> sortedTasks = _sortTasks(success);
          emit(GetAllTaskState(
              sortType: _currentSortType,
              status: Status.success,
              message: 'list task result',
              listTask: sortedTasks));
        },
      );
    } catch (_) {
      emit(const ErrorState(status: Status.error, message: unknownError));
    }
  }

  Future<void> _addTaskEvent(
      AddTaskEvent event, Emitter<BaseState> emit) async {
    emit(const AddTaskLoadingState(
        status: Status.loading, message: 'loading...'));
    try {
      final payload = {
        "title": titleControllerField.text,
        "description": descriptionControllerField.text
      };
      final result = await createTaskUseCase(CreateTaskParams(data: payload));
      result.fold(
        (failure) {
          if (failure is NoConnectionFailure) {
            emit(const ErrorState(
                status: Status.error, message: noConnexionMessage));
          } else if (failure is ServerFailure) {
            emit(const ErrorState(status: Status.error, message: serverError));
          } else {
            emit(const ErrorState(status: Status.error, message: unknownError));
          }
        },
        (success) {
          titleControllerField.clear();
          descriptionControllerField.clear();
          add(GetListTaskEvent());
        },
      );
    } catch (_) {
      emit(const ErrorState(status: Status.error, message: unknownError));
    }
  }

  Future<void> _deleteTaskEvent(
      DeleteTaskEvent event, Emitter<BaseState> emit) async {
    emit(const DeleteLoadingState(
        status: Status.loading, message: 'loading...'));
    try {
      final result = await deleteTaskUseCase(DeleteTaskParams(id: event.id));
      result.fold(
        (failure) {
          if (failure is NoConnectionFailure) {
            emit(const ErrorState(
                status: Status.error, message: noConnexionMessage));
          } else if (failure is ServerFailure) {
            emit(const ErrorState(status: Status.error, message: serverError));
          } else {
            emit(const ErrorState(status: Status.error, message: unknownError));
          }
        },
        (success) {
          add(GetListTaskEvent());
        },
      );
    } catch (_) {
      emit(const ErrorState(status: Status.error, message: unknownError));
    }
  }

  Future<void> _updateTaskEvent(
      UpdateTaskEvent event, Emitter<BaseState> emit) async {
    emit(const BaseState(status: Status.loading, message: 'loading...'));
    try {
      final result = await updateTaskUseCase(
          UpdateTaskParams(id: event.id, isCompleted: event.isCompleted));
      result.fold(
        (failure) {
          if (failure is NoConnectionFailure) {
            emit(const ErrorState(
                status: Status.error, message: noConnexionMessage));
          } else if (failure is ServerFailure) {
            emit(const ErrorState(status: Status.error, message: serverError));
          } else {
            emit(const ErrorState(status: Status.error, message: unknownError));
          }
        },
        (success) {
          add(GetListTaskEvent());
        },
      );
    } catch (_) {
      emit(const ErrorState(status: Status.error, message: unknownError));
    }
  }

  Future<void> _sortTasksEvent(
      SortTasksEvent event, Emitter<BaseState> emit) async {
    emit(const BaseState(status: Status.loading, message: 'loading...'));
    _currentSortType = event.sortType;
    // Appliquer le tri selon le type sélectionné
    List<Task> tasks = (selectedIndex == 0)
        ? _tasks
        : _tasks.where((task) => task.isCompleted).toList();
    final sortedTasks = _sortTasks(tasks);

    emit(
      GetAllTaskState(
          listTask: sortedTasks,
          sortType: _currentSortType,
          status: Status.success,
          message: "${DateTime.now().microsecondsSinceEpoch}"),
    );
  }

  Future<void> _filterCompletedTasksEvent(
      FilterCompletedTasksEvent event, Emitter<BaseState> emit) async {
    selectedIndex = 1;
    List<Task> completedTasks =
        _tasks.where((task) => task.isCompleted).toList();
    List<Task> sortedTasks = _sortTasks(completedTasks);
    emit(GetAllTaskState(
        listTask: sortedTasks,
        sortType: _currentSortType,
        status: Status.success,
        message: 'Tasks completed'));
  }
}
