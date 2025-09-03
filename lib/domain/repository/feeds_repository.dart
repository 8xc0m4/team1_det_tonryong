import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';

abstract interface class FeedsRepository {
  Future<List<HomeEntity>?> getFeedsPhoto();
  Future<List<CommentEntity>> getComment(String id);
  Future<void> createComment({
    required String id,
    required String commentUserNM,
    required String comment,
  });
  Future<void> updateCommentLike({
    required String commentId,
    required String feedId,
    required String userNM,
    required bool isLike,
  });
}
