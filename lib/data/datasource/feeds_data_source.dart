import 'package:team1_det_tonryong/data/dto/comment_dto.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

abstract interface class FeedsDataSource {
  Future<List<FeedDto>?> getFeeds();
  Future<List<CommentDto>> getComments(String id);
  Future<void> createComment({
    required String id,
    required CommentDto comment,
  });
  Future<void> updateCommentLike({
    required String commentId,
    required String feedId,
    required String userNM,
    required bool isLike,
  });
}
