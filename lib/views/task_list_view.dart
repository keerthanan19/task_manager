import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/routes.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/providers/auth_providers.dart';
import 'package:task_manager/providers/task_providers.dart';
import 'package:task_manager/widgets/bottom_nav.dart';
import 'package:task_manager/widgets/filter_chips.dart';
import 'package:task_manager/widgets/task_card.dart';

class TaskListView extends ConsumerWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    if (user == null) return const SizedBox.shrink();

    final filter = ref.watch(taskFilterProvider);
    final searchQuery = ref.watch(taskSearchProvider);
    final sortOption = ref.watch(taskSortProvider);
    final tasksAsync = ref.watch(taskListProvider(user.uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.taskForm);
        },
      ),
      bottomNavigationBar: const BottomNav(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search tasks',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                ref.read(taskSearchProvider.notifier).state = value;
              },
            ),
          ),
          const FilterChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Force refresh by invalidating the stream provider
                ref.invalidate(taskListProvider(user.uid));
              },
              child: tasksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (tasks) {
                  // Apply sorting
                  final sortedTasks = _sortTasks(tasks, sortOption);
                  
                  // Apply filtering and searching
                  final filteredTasks = sortedTasks.where((task) {
                    final matchesFilter = filter == 'All' ||
                        (filter == 'Pending' && !task.isCompleted) ||
                        (filter == 'Completed' && task.isCompleted);
                    
                    final matchesSearch = searchQuery.isEmpty ||
                        task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                        task.description.toLowerCase().contains(searchQuery.toLowerCase());
                    
                    return matchesFilter && matchesSearch;
                  }).toList();

                  if (filteredTasks.isEmpty) {
                    return const Center(child: Text('No tasks found'));
                  }

                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCard(
                        task: task,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.taskForm,
                            arguments: task,
                          );
                        },
                        onToggle: (value) async {
                          await ref
                              .read(taskControllerProvider.notifier)
                              .toggleTaskCompletion(task);
                        },
                        onDelete: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                  'Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await ref
                                        .read(taskControllerProvider.notifier)
                                        .deleteTask(task.id!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _sortTasks(List<Task> tasks, String sortOption) {
    switch (sortOption) {
      case 'Newest First':
        return tasks..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case 'Oldest First':
        return tasks..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case 'Title A-Z':
        return tasks..sort((a, b) => a.title.compareTo(b.title));
      case 'Title Z-A':
        return tasks..sort((a, b) => b.title.compareTo(a.title));
      case 'Pending First':
        return tasks..sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? 1 : -1;
        });
      case 'Completed First':
        return tasks..sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return b.isCompleted ? 1 : -1;
        });
      default:
        return tasks;
    }
  }

  void _showSortDialog(BuildContext context, WidgetRef ref) {
    final currentSort = ref.read(taskSortProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort Tasks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Newest First'),
              value: 'Newest First',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Oldest First'),
              value: 'Oldest First',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Title A-Z'),
              value: 'Title A-Z',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Title Z-A'),
              value: 'Title Z-A',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Pending First'),
              value: 'Pending First',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Completed First'),
              value: 'Completed First',
              groupValue: currentSort,
              onChanged: (value) {
                ref.read(taskSortProvider.notifier).state = value.toString();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}