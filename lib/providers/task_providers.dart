import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/controllers/task_controller.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/task_service.dart';

final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

final taskControllerProvider =
    StateNotifierProvider<TaskController, AsyncValue<void>>(
  (ref) => TaskController(ref.read(taskServiceProvider)),
);

final taskListProvider = StreamProvider.autoDispose.family<List<Task>, String>(
  (ref, userId) => ref.read(taskServiceProvider).getTasks(userId),
);

final taskFilterProvider = StateProvider<String>((ref) => 'All');
final taskSearchProvider = StateProvider<String>((ref) => '');
// Add to task_providers.dart
final taskSortProvider = StateProvider<String>((ref) => 'Newest First');