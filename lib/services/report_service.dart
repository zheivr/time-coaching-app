import '../models/activity.dart';
import '../repositories/activity_repository.dart';
import '../repositories/category_repository.dart';

class DailyReport {
  final DateTime date;
  final List<Activity> activities;
  final Map<int, int> categoryBreakdown; // categoryId -> minutes
  final int totalMinutes;

  DailyReport({
    required this.date,
    required this.activities,
    required this.categoryBreakdown,
    required this.totalMinutes,
  });
}

class ReportService {
  final ActivityRepository _activityRepository = ActivityRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  /// Get a daily report for a specific date
  Future<DailyReport> getDailyReport(DateTime date) async {
    final activities = await _activityRepository.getActivitiesByDate(date);

    final categoryBreakdown = <int, int>{};
    int totalMinutes = 0;

    for (final activity in activities) {
      if (activity.endTime != null) {
        final minutes = activity.elapsedMinutes;
        categoryBreakdown[activity.categoryId] =
            (categoryBreakdown[activity.categoryId] ?? 0) + minutes;
        totalMinutes += minutes;
      }
    }

    return DailyReport(
      date: date,
      activities: activities,
      categoryBreakdown: categoryBreakdown,
      totalMinutes: totalMinutes,
    );
  }

  /// Get category breakdown by name for a specific date
  Future<Map<String, int>> getCategoryBreakdown(DateTime date) async {
    final report = await getDailyReport(date);
    final categories = await _categoryRepository.getAllCategories();

    final result = <String, int>{};
    for (final category in categories) {
      result[category.name] = report.categoryBreakdown[category.id] ?? 0;
    }
    return result;
  }

  /// Get weekly report (7 days)
  Future<Map<DateTime, DailyReport>> getWeeklyReport(DateTime date) async {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final result = <DateTime, DailyReport>{};

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      result[day] = await getDailyReport(day);
    }
    return result;
  }

  /// Get monthly report (all days in the month)
  Future<Map<DateTime, DailyReport>> getMonthlyReport(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    final result = <DateTime, DailyReport>{};

    for (int i = 0; i < endOfMonth.day; i++) {
      final day = startOfMonth.add(Duration(days: i));
      result[day] = await getDailyReport(day);
    }
    return result;
  }

  /// Get total minutes for a category on a specific date
  Future<int> getCategoryTotalMinutes(int categoryId, DateTime date) async {
    final report = await getDailyReport(date);
    return report.categoryBreakdown[categoryId] ?? 0;
  }
}
