import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';

class GetFeedsUsecase {
  GetFeedsUsecase(this._feedsRepository);
  final FeedsRepository _feedsRepository;

  Future<List<HomeEntity>?> execute() async {
    return await _feedsRepository.getFeedsPhoto();
  }

  Future<List<CommentEntity>> executeGetComment(
    String id,
  ) async {
    return await _feedsRepository.getComment(id);
  }

  Future<void> executeCreateComment({
    required String id,
    required String commentUserNM,
    required String comment,
  }) async {
    return await _feedsRepository.createComment(
      id: id,
      commentUserNM: commentUserNM,
      comment: comment,
    );
  }

  Future<void> executeUpdataCommentLike({
    required String commentId,
    required String feedId,
    required String userNM,
    required bool isLike,
  }) async {
    return await _feedsRepository.updateCommentLike(
      commentId: commentId,
      feedId: feedId,
      userNM: userNM,
      isLike: isLike,
    );
  }
}
