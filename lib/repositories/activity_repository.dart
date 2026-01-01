import 'package:sqflite/sqflite.dart';
import '../models/activity.dart';
import '../utils/constants.dart';
import 'database_helper.dart';

class ActivityRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertActivity(Activity activity) async {
    final db = await _dbHelper.database;
    return await db.insert(
      AppConstants.tableActivities,
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateActivity(Activity activity) async {
    final db = await _dbHelper.database;
    return await db.update(
      AppConstants.tableActivities,
      activity.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  Future<int> deleteActivity(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      AppConstants.tableActivities,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Activity>> getActivitiesByDate(DateTime date) async {
    final db = await _dbHelper.database;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final maps = await db.query(
      AppConstants.tableActivities,
      where: 'start_time >= ? AND start_time < ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
      orderBy: 'start_time ASC',
    );
    return List.generate(maps.length, (i) => Activity.fromMap(maps[i]));
  }

  Future<Activity?> getActivityById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      AppConstants.tableActivities,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Activity.fromMap(maps.first);
    }
    return null;
  }

  Future<Activity?> getCurrentActivity() async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      AppConstants.tableActivities,
      where: 'end_time IS NULL',
      orderBy: 'start_time DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Activity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Activity>> getActivitiesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      AppConstants.tableActivities,
      where: 'start_time >= ? AND start_time < ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'start_time ASC',
    );
    return List.generate(maps.length, (i) => Activity.fromMap(maps[i]));
  }
}
