import 'base_state.dart';

class ErrorState extends BaseState {
  final dynamic body;
  const ErrorState({
    required Status status,
    required String message,
    this.body,
  }) : super(
          status: status,
          message: message,
        );
}
