import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);

    return openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create categories table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableCategories} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        color TEXT NOT NULL,
        icon_name TEXT,
        order_index INTEGER,
        is_active BOOLEAN DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create activities table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableActivities} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        start_time DATETIME NOT NULL,
        end_time DATETIME,
        memo TEXT,
        duration_minutes INTEGER,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES ${AppConstants.tableCategories}(id)
      )
    ''');

    // Create tags table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableTags} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        color TEXT,
        usage_count INTEGER DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create activity_tags table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableActivityTags} (
        activity_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        PRIMARY KEY (activity_id, tag_id),
        FOREIGN KEY (activity_id) REFERENCES ${AppConstants.tableActivities}(id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id) REFERENCES ${AppConstants.tableTags}(id) ON DELETE CASCADE
      )
    ''');

    // Create indexes for performance
    await db.execute('''
      CREATE INDEX idx_activities_category_id ON ${AppConstants.tableActivities}(category_id)
    ''');
    await db.execute('''
      CREATE INDEX idx_activities_start_time ON ${AppConstants.tableActivities}(start_time)
    ''');
    await db.execute('''
      CREATE INDEX idx_activity_tags_tag_id ON ${AppConstants.tableActivityTags}(tag_id)
    ''');

    // Insert default categories
    await _insertDefaultCategories(db);
  }

  Future<void> _insertDefaultCategories(Database db) async {
    for (int i = 0; i < AppConstants.defaultCategories.length; i++) {
      await db.insert(
        AppConstants.tableCategories,
        {
          'name': AppConstants.defaultCategories[i],
          'color': AppConstants.defaultColors[i],
          'order_index': i,
        },
      );
    }
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
