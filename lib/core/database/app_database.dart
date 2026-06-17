import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:studentmanagement/fetaures/home_screen/data/local/dao/feed_dao.dart';
import 'package:studentmanagement/fetaures/home_screen/data/local/entity/feed_table.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [FeedTable])
abstract class AppDatabase extends FloorDatabase {
  FeedDao get feedDao;
}
