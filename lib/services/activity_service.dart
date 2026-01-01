import '../models/activity.dart';
import '../repositories/activity_repository.dart';

class ActivityService {
  final ActivityRepository _repository = ActivityRepository();

  /// Start a new activity
  Future<Activity> startActivity(int categoryId, {String? memo}) async {
    final now = DateTime.now();
    final activity = Activity(
      id: now.millisecondsSinceEpoch,
      categoryId: categoryId,
      startTime: now,
      memo: memo,
      createdAt: now,
      updatedAt: now,
    );
    await _repository.insertActivity(activity);
    return activity;
  }

  /// Stop the current activity
  Future<Activity?> stopActivity() async {
    final currentActivity = await _repository.getCurrentActivity();
    if (currentActivity == null) return null;

    final now = DateTime.now();
    final durationMinutes = now.difference(currentActivity.startTime).inMinutes;
    final updatedActivity = currentActivity.copyWith(
      endTime: now,
      durationMinutes: durationMinutes,
      updatedAt: now,
    );
    await _repository.updateActivity(updatedActivity);
    return updatedActivity;
  }

  /// Update an activity
  Future<void> updateActivity(Activity activity) async {
    await _repository.updateActivity(activity);
  }

  /// Delete an activity
  Future<void> deleteActivity(int activityId) async {
    await _repository.deleteActivity(activityId);
  }

  /// Get today's activities
  Future<List<Activity>> getTodayActivities() async {
    return await _repository.getActivitiesByDate(DateTime.now());
  }

  /// Get activities by date range
  Future<List<Activity>> getActivitiesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _repository.getActivitiesByDateRange(startDate, endDate);
  }

  /// Get the current (ongoing) activity
  Future<Activity?> getCurrentActivity() async {
    return await _repository.getCurrentActivity();
  }
}
