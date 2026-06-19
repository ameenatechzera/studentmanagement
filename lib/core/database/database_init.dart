// import 'app_database.dart';
// import 'dart:async';

// class DatabaseInit {
//   static AppDatabase? _database;

//   static Future<AppDatabase> init() async {
//     _database ??= await $FloorAppDatabase
//         .databaseBuilder('app_database.db')
//         .build();

//     return _database!;
//   }
// }
import 'package:studentmanagement/core/database/app_database.dart';

class DatabaseInit {
  static AppDatabase? _database;

  static Future<AppDatabase> init() async {
    if (_database != null) return _database!;

    _database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();

    print("🧠 DB CREATED HASH: ${_database.hashCode}");

    return _database!;
  }

  static AppDatabase get instance {
    if (_database == null) {
      throw Exception("DB not initialized");
    }
    return _database!;
  }
}
