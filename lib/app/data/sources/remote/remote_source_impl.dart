import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:to_do_list/app/core/errors/exceptions.dart';
import 'package:to_do_list/app/core/http/http_client.dart' as http_client;
import 'package:to_do_list/app/core/utils/constants.dart';
import 'package:to_do_list/app/data/models/task_model.dart';
import 'package:to_do_list/app/data/sources/remote/remote_config.dart';
import 'package:to_do_list/app/data/sources/remote/remote_source.dart';

class RemoteSourceImpl extends RemoteSource {
  late http_client.HttpClient client;

  RemoteSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final url = Uri.parse(RemoteEndpoint.getAllTask);
    final response = await client.get(url);
    Iterable iterable = json.decode(response.body);
    if (response.statusCode == httpStatusCodes[HttpStatus.ok]) {
      try {
        return iterable.map((e) => TaskModel.fromJson(e)).toList();
      } catch (e) {
        rethrow;
      }
    } else {
      throw ServerException(
          statusCode: response.statusCode,
          message: response.reasonPhrase ?? 'Server Error',
          body: response.body);
    }
  }

  @override
  Future<bool> addTask({required Map<String, dynamic> data}) async {
    final url = Uri.parse(RemoteEndpoint.addTask);
    final response = await client.post(url, body: jsonEncode(data));
    if (response.statusCode == httpStatusCodes[HttpStatus.ok]) {
      try {
        return true;
      } catch (e) {
        rethrow;
      }
    } else {
      throw ServerException(
          statusCode: response.statusCode,
          message: response.reasonPhrase ?? 'Server Error',
          body: response.body);
    }
  }

  @override
  Future<bool> deleteTask({required String id}) async {
    final url = Uri.parse(RemoteEndpoint.deleteTask(id));
    final response = await client.delete(url);
    if (response.statusCode == httpStatusCodes[HttpStatus.noContent]) {
      try {
        return true;
      } catch (e) {
        rethrow;
      }
    } else {
      throw ServerException(
          statusCode: response.statusCode,
          message: response.reasonPhrase ?? 'Server Error',
          body: response.body);
    }
  }

  @override
  Future<bool> updateTask(
      {required String id, required bool isCompleted}) async {
    final url = Uri.parse(RemoteEndpoint.updateTask(id));
    final response =
        await client.put(url, body: jsonEncode({"isCompleted": isCompleted}));
    if (response.statusCode == httpStatusCodes[HttpStatus.ok]) {
      try {
        return true;
      } catch (e) {
        rethrow;
      }
    } else {
      throw ServerException(
          statusCode: response.statusCode,
          message: response.reasonPhrase ?? 'Server Error',
          body: response.body);
    }
  }
}
