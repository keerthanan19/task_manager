import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/views/login_view.dart';
import 'package:task_manager/views/register_view.dart';
import 'package:task_manager/views/settings_screen.dart';
import 'package:task_manager/views/splash_view.dart';
import 'package:task_manager/views/task_form_view.dart';
import 'package:task_manager/views/task_list_view.dart';


class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String taskList = '/tasks';
  static const String taskForm = '/task-form';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case taskList:
        return MaterialPageRoute(builder: (_) => const TaskListView());
      case taskForm:
        final task = settings.arguments as Task?;
        return MaterialPageRoute(
          builder: (_) => TaskFormView(task: task),
        );
       case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}