import 'package:team1_det_tonryong/data/dto/comment_dto.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

abstract interface class FeedsDataSource {
  Future<List<FeedDto>?> getFeeds();
  Future<FeedDto> getDetail(String id); //detail
  Future<List<CommentDto>> getBestComments(String id);
  Future<void> feedLikeUpdate({
    required String feedId,
    required bool liked,
    required String userNM,
  });
}
