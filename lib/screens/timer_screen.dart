import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/activity_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/category_selector.dart';
import '../widgets/timer_display.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentActivity = ref.watch(timerProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer display
              TimerDisplay(activity: currentActivity),
              const SizedBox(height: 48),

              // Category selector or stop button
              if (currentActivity == null)
                categoriesAsync.when(
                  data: (categories) => CategorySelector(
                    categories: categories,
                    onCategorySelected: (categoryId) {
                      ref.read(timerProvider.notifier).startActivity(categoryId);
                    },
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Error: $err'),
                )
              else
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref.read(timerProvider.notifier).stopActivity();
                    // ignore: unused_result
                    ref.refresh(todayActivitiesProvider);
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop Activity'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
