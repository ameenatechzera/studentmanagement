import 'package:floor/floor.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

@dao
abstract class FeedDao {
  @Insert()
  Future<void> insertfeeds(List<FeedDetails> article);

  @Query('SELECT * FROM tbl_feeds')
  Future<List<FeedDetails>> getallfeeds();

  @Query("SELECT COUNT(*) from tbl_feeds")
  Future<int?> countFeed();

  @Query('DELETE FROM tbl_feeds')
  Future<void> deleteAll();
}
