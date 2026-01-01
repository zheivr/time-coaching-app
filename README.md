# Personal Time Coaching App

A Flutter-based iOS application that helps users track, visualize, and improve their time management through simple, intuitive interfaces and data-driven insights.

## 🎯 Overview

**Personal Time Coaching App** is a lightweight, privacy-first time tracking application designed to help you understand how you spend your time. With a focus on simplicity and performance, the app provides:

- **Real-time time tracking** with one-touch start/stop
- **Daily timeline view** showing all activities in chronological order
- **Visual reports** with pie charts showing time distribution
- **Customizable categories** for organizing your activities
- **Offline-first architecture** with local SQLite database

## ✨ Key Features

### Phase 1 (MVP) - Current
- ⏱️ **Time Tracking**: Start/stop activities with a single tap
- 📅 **Timeline View**: See all today's activities in order
- 📊 **Daily Report**: Visual breakdown of time usage with pie chart
- 🏷️ **Categories**: Pre-defined categories (Work, Study, Exercise, Rest, Meal, Other)
- 💾 **Local Storage**: All data stored securely on your device

### Phase 2 (Planned)
- 🏷️ **Tagging System**: Add detailed tags to activities
- 📈 **Weekly/Monthly Reports**: Extended time analysis
- ✏️ **Activity Editing**: Modify recorded activities
- 🎨 **Custom Categories**: Create your own activity categories

### Phase 3 (Future)
- 🤖 **AI Coaching**: Rule-based feedback and suggestions
- 📊 **Trend Analysis**: Identify patterns in your time usage
- 🎯 **Goal Setting**: Set and track time management goals

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (stable channel)
- Dart 3.10.4 or later
- Xcode (for iOS development)

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd time_coaching_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   # On iOS simulator
   flutter run -d "iPhone 15"
   
   # On physical device
   flutter run
   ```

## 📱 Usage

### Starting a Time Tracking Session

1. Open the app and go to the **Timer** tab
2. Select a category from the grid (e.g., "Work", "Study")
3. The timer starts counting immediately
4. Tap **Stop Activity** when you're done
5. The activity is automatically saved

### Viewing Your Timeline

1. Tap the **Timeline** tab
2. See all activities for today listed chronologically
3. Each entry shows:
   - Time range (start - end)
   - Category name (color-coded)
   - Duration in minutes
   - Optional memo/notes

### Checking Your Daily Report

1. Tap the **Report** tab
2. View a pie chart showing how your time is distributed
3. See a detailed summary with:
   - Time spent in each category
   - Percentage of total time
   - Total time tracked

## 🏗️ Architecture

The app follows a clean, layered architecture:

```
┌─────────────────────────────────────────┐
│         UI Layer (Screens)              │
│  - Timer, Timeline, Report screens      │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    State Management (Riverpod)          │
│  - Activity, Category, Report providers │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Business Logic (Services)            │
│  - ActivityService, ReportService       │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Data Access (Repositories)           │
│  - ActivityRepository, CategoryRepo     │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Database (SQLite)                    │
│  - Local data persistence               │
└─────────────────────────────────────────┘
```

## 📊 Technology Stack

| Component | Technology |
|-----------|-----------|
| Framework | Flutter |
| Language | Dart |
| Database | SQLite |
| State Management | Riverpod |
| Charts | fl_chart |

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── activity.dart
│   └── category.dart
├── repositories/                # Data access layer
│   ├── database_helper.dart
│   ├── activity_repository.dart
│   └── category_repository.dart
├── services/                    # Business logic
│   ├── activity_service.dart
│   ├── category_service.dart
│   └── report_service.dart
├── providers/                   # State management
│   ├── activity_provider.dart
│   ├── category_provider.dart
│   └── report_provider.dart
├── screens/                     # UI screens
│   ├── home_screen.dart
│   ├── timer_screen.dart
│   ├── timeline_screen.dart
│   └── report_screen.dart
├── widgets/                     # Reusable components
│   ├── timer_display.dart
│   ├── category_selector.dart
│   ├── activity_tile.dart
│   └── pie_chart_widget.dart
└── utils/
    └── constants.dart
```

## 🔐 Privacy & Data

- **Local-First**: All data is stored locally on your device
- **Offline**: The app works completely offline
- **No Cloud Sync**: Your data never leaves your device
- **No Tracking**: No analytics or user tracking
- **Secure**: SQLite database with proper schema

## 🧪 Testing

Run code analysis:
```bash
flutter analyze
```

Run tests (when available):
```bash
flutter test
```

## 📝 Development Notes

### Adding a New Feature

1. Create model in `lib/models/`
2. Create repository in `lib/repositories/`
3. Create service in `lib/services/`
4. Create provider in `lib/providers/`
5. Create UI in `lib/screens/` or `lib/widgets/`

### Database Migrations

Database schema is defined in `lib/repositories/database_helper.dart`. To add new tables:

1. Update `_onCreate()` method
2. Increment `dbVersion` in `lib/utils/constants.dart`
3. Test on a fresh install

## 🐛 Troubleshooting

### App won't start
- Clear app data: `flutter clean && flutter pub get`
- Rebuild: `flutter run`

### Timer not updating
- Check app permissions
- Restart the app

### Database errors
- Ensure SQLite version is compatible
- Check database file permissions

## 📚 Documentation

- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) - Detailed implementation overview
- [Flutter Documentation](https://flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)

## 🤝 Contributing

This is a personal project. For suggestions or improvements, please create an issue or pull request.

## 📄 License

Personal use only.

## 🎓 Credits

Built with:
- [Flutter](https://flutter.dev)
- [Riverpod](https://riverpod.dev)
- [fl_chart](https://github.com/imaNNeoFighT/fl_chart)

## 📞 Support

For issues or questions, please refer to the troubleshooting section or check the implementation summary.

---

**Version**: 1.0.0 (Phase 1 - MVP)  
**Last Updated**: January 1, 2026  
**Status**: ✅ Complete and Ready for Use
