import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/activity.dart';
import '../services/activity_service.dart';

final activityServiceProvider = Provider((ref) => ActivityService());

// Get today's activities
final todayActivitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final service = ref.watch(activityServiceProvider);
  return service.getTodayActivities();
});

// Get the current (ongoing) activity
final currentActivityProvider =
    FutureProvider<Activity?>((ref) async {
  final service = ref.watch(activityServiceProvider);
  return service.getCurrentActivity();
});

// Timer state notifier
class TimerNotifier extends StateNotifier<Activity?> {
  final ActivityService _service;

  TimerNotifier(this._service) : super(null) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = await _service.getCurrentActivity();
  }

  Future<void> startActivity(int categoryId, {String? memo}) async {
    final activity = await _service.startActivity(categoryId, memo: memo);
    state = activity;
  }

  Future<void> stopActivity() async {
    await _service.stopActivity();
    state = null;
  }

  Future<void> refreshCurrentActivity() async {
    state = await _service.getCurrentActivity();
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, Activity?>((ref) {
  final service = ref.watch(activityServiceProvider);
  return TimerNotifier(service);
});
