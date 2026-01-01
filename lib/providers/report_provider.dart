import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/report_service.dart';

final reportServiceProvider = Provider((ref) => ReportService());

// Get daily report for a specific date
final dailyReportProvider =
    FutureProvider.family<DailyReport, DateTime>((ref, date) async {
  final service = ref.watch(reportServiceProvider);
  return service.getDailyReport(date);
});

// Get category breakdown by name for a specific date
final categoryBreakdownProvider =
    FutureProvider.family<Map<String, int>, DateTime>((ref, date) async {
  final service = ref.watch(reportServiceProvider);
  return service.getCategoryBreakdown(date);
});

// Get weekly report
final weeklyReportProvider =
    FutureProvider.family<Map<DateTime, DailyReport>, DateTime>(
        (ref, date) async {
  final service = ref.watch(reportServiceProvider);
  return service.getWeeklyReport(date);
});

// Get monthly report
final monthlyReportProvider =
    FutureProvider.family<Map<DateTime, DailyReport>, DateTime>(
        (ref, date) async {
  final service = ref.watch(reportServiceProvider);
  return service.getMonthlyReport(date);
});
