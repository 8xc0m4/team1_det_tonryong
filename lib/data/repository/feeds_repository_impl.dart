import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
import 'package:team1_det_tonryong/data/dto/comment_dto.dart';
import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';

class FeedsRepositoryImpl implements FeedsRepository {
  FeedsRepositoryImpl(this._feedsDataSource);
  final FeedsDataSource _feedsDataSource;
  @override
  Future<List<HomeEntity>?> getFeedsPhoto() async {
    final result = await _feedsDataSource.getFeeds();
    if (result == null) {
      return null;
    }
    return result
        .map(
          (e) => HomeEntity(e.feedPhoto),
        )
        .toList();
  }

  @override
  Future<List<CommentEntity>> getComment(id) async {
    final result = await _feedsDataSource.getComments(id);
    if (result.isEmpty) {
      return [];
    }
    return result
        .map(
          (doc) => CommentEntity(
            commentId: doc.commentId,
            commentTime: doc.commentTime,
            commentLike: doc.commentLike,
            commentUserNM: doc.commentUserNM,
            comment: doc.comment,
            cLikeUsers: doc.cLikeUsers,
          ),
        )
        .toList();
  }

  @override
  Future<void> createComment({
    required String id,
    required String commentUserNM,
    required String comment,
  }) async {
    final commentDto = CommentDto(
      commentId: '',
      commentTime: DateTime.now(),
      commentLike: 0,
      commentUserNM: commentUserNM,
      comment: comment,
      cLikeUsers: [],
    );
    await _feedsDataSource.createComment(
      id: id,
      comment: commentDto,
    );
  }

  @override
  Future<void> updateCommentLike({
    required String commentId,
    required String feedId,
    required String userNM,
    required bool isLike,
  }) async {
    await _feedsDataSource.updateCommentLike(
      commentId: commentId,
      feedId: feedId,
      userNM: userNM,
      isLike: isLike,
    );
  }
}
