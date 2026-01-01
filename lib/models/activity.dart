class Activity {
  final int id;
  final int categoryId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? memo;
  final int? durationMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Activity({
    required this.id,
    required this.categoryId,
    required this.startTime,
    this.endTime,
    this.memo,
    this.durationMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Check if activity is ongoing
  bool get isOngoing => endTime == null;

  // Calculate elapsed time in minutes
  int get elapsedMinutes {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime).inMinutes;
  }

  // Format elapsed time as HH:MM:SS
  String get elapsedTimeFormatted {
    final duration = Duration(minutes: elapsedMinutes);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'memo': memo,
      'duration_minutes': durationMinutes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create from Map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as int,
      categoryId: map['category_id'] as int,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: map['end_time'] != null ? DateTime.parse(map['end_time'] as String) : null,
      memo: map['memo'] as String?,
      durationMinutes: map['duration_minutes'] as int?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  // Copy with method
  Activity copyWith({
    int? id,
    int? categoryId,
    DateTime? startTime,
    DateTime? endTime,
    String? memo,
    int? durationMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Activity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      memo: memo ?? this.memo,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'Activity(id: $id, categoryId: $categoryId, isOngoing: $isOngoing)';
}
