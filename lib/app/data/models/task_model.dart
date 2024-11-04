import 'package:json_annotation/json_annotation.dart';
import 'package:to_do_list/app/domain/entities/task.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.isCompleted,
    required super.createdAt,
    required super.description,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
