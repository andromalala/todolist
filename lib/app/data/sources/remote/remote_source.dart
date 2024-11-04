import 'package:to_do_list/app/data/models/task_model.dart';

abstract class RemoteSource {
  Future<List<TaskModel>> getAllTasks();

  Future<bool> addTask({required Map<String, dynamic> data});

  Future<bool> updateTask({
    required String id,
    required bool isCompleted,
  });

  Future<bool> deleteTask({
    required String id,
  });
}
