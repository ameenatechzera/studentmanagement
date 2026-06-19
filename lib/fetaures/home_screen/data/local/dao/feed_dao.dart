import 'package:floor/floor.dart';
import '../entity/feed_table.dart';

@dao
abstract class FeedDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFeed(FeedTable feed);

  @Query('SELECT * FROM feed_table ORDER BY feedId DESC')
  Future<List<FeedTable>> getAllFeeds();

  @Query('DELETE FROM feed_table')
  Future<void> clearFeeds();
}
