import 'package:floor/floor.dart';

@Entity(tableName: 'feed_table')
class FeedTable {
  @primaryKey
  final int feedId;

  final String feedJson;

  FeedTable({required this.feedId, required this.feedJson});
}
