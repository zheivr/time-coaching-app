class AppConstants {
  // Database
  static const String dbName = 'time_coaching.db';
  static const int dbVersion = 1;

  // Table names
  static const String tableCategories = 'categories';
  static const String tableActivities = 'activities';
  static const String tableTags = 'tags';
  static const String tableActivityTags = 'activity_tags';

  // Default categories
  static const List<String> defaultCategories = [
    'Work',
    'Study',
    'Exercise',
    'Rest',
    'Meal',
    'Other',
  ];

  // Default colors for categories
  static const List<String> defaultColors = [
    '#FF6B6B', // Red
    '#4ECDC4', // Teal
    '#45B7D1', // Blue
    '#FFA07A', // Light Salmon
    '#98D8C8', // Mint
    '#F7DC6F', // Yellow
  ];
}
