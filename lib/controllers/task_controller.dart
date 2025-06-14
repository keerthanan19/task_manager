import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/task_service.dart';

class TaskController extends StateNotifier<AsyncValue<void>> {
  final TaskService _taskService;
  TaskController(this._taskService) : super(const AsyncValue.data(null));

  Future<void> addTask(Task task) async {
    state = const AsyncValue.loading();
    try {
      await _taskService.addTask(task);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(Task task) async {
    state = const AsyncValue.loading();
    try {
      await _taskService.updateTask(task);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      await _taskService.deleteTask(taskId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    state = const AsyncValue.loading();
    try {
      await _taskService.toggleTaskCompletion(task);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}