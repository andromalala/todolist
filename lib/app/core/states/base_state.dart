import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  final Status status;
  final String message;

  const BaseState({
    required this.status,
    required this.message,
  });

  @override
  List<Object?> get props => [status, message];

  BaseState copyWith({
    Status? status,
    String? message,
  }) {
    return BaseState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

enum Status {
  initial,
  loginInitial,
  notLogged,
  loading,
  success,
  error,
  logged,
}
