part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class GetListTaskEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  const AddTaskEvent();

  @override
  List<Object?> get props => [];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class UpdateTaskEvent extends TaskEvent {
  final String id;
  final bool isCompleted;

  const UpdateTaskEvent({required this.id, required this.isCompleted});

  @override
  List<Object?> get props => [id, isCompleted];
}

class SortTasksEvent extends TaskEvent {
  final SortType sortType;

  const SortTasksEvent({required this.sortType});

  @override
  List<Object?> get props => [sortType];
}

class FilterCompletedTasksEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}
