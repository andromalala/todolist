import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/core/utils/theme.dart';
import 'package:to_do_list/app/presentation/routes/app_observer.dart';
import 'package:to_do_list/app/presentation/routes/app_routes.dart';
import 'package:to_do_list/di/injection_providers.dart';
import 'package:to_do_list/di/injection_container.dart' as di;
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    BlocOverrides.runZoned(
      () {
        runApp(const MyApp());
      },
      blocObserver: GlobalBlocObserver(),
    );
  }, (exception, stackTrace) async {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'To do list',
        theme: CustomTheme.themeData,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.home,
        locale: const Locale('fr', 'FR'),
        navigatorObservers: [AppObserver()],
      ),
    );
  }
}
