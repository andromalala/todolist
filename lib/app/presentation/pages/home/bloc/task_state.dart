part of 'task_bloc.dart';

class TaskState extends BaseState {
  const TaskState({
    required super.status,
    required super.message,
  });
}

class TaskLoadingState extends BaseState {
  const TaskLoadingState({
    required super.status,
    required super.message,
  });
}

class GetAllTaskState extends BaseState {
  final List<Task> listTask;
  final SortType sortType;
  final int selectedIndex;

  const GetAllTaskState({
    required this.listTask,
    required this.sortType,
    this.selectedIndex = 0,
    required super.status,
    required super.message,
  });

  @override
  List<Object> get props =>
      [listTask, sortType, status, message, selectedIndex];
}

class AddTaskLoadingState extends BaseState {
  const AddTaskLoadingState({
    required super.status,
    required super.message,
  });
}

class DeleteLoadingState extends BaseState {
  const DeleteLoadingState({
    required super.status,
    required super.message,
  });
}
