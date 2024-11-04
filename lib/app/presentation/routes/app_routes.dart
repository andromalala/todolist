import 'package:flutter/cupertino.dart';
import 'package:to_do_list/app/presentation/pages/home/add_task_page.dart';
import 'package:to_do_list/app/presentation/pages/home/home_page.dart';

abstract class AppRoutes {
  static const home = '/home';
  static const addTask = '/add_task';

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home: (BuildContext context) => HomePage(),
    AppRoutes.addTask: (BuildContext context) => const AddTaskPage(),
  };
}
