import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;
  final dynamic body;
  final int statusCode;
  ServerFailure({
    required this.message,
    required this.body,
    required this.statusCode,
  });
  @override
  List<Object> get props => [
        message,
        body,
      ];

  @override
  bool? get stringify => true;
}

class NoConnectionFailure extends Failure {}
