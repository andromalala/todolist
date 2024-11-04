import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/presentation/pages/home/bloc/task_bloc.dart';
import 'injection_container.dart';
import 'package:provider/single_child_widget.dart';

/// inject providers
List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => sl<TaskBloc>()..add(GetListTaskEvent())),
];

class GlobalBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('${bloc.runtimeType}, $transition\n');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('${bloc.runtimeType}\n');
  }
}
