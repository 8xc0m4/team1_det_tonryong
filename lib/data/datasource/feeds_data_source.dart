import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

abstract interface class FeedsDataSource {
  Future<List<FeedDto>?> getFeeds();
}