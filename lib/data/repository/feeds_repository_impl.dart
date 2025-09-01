import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
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
            commentTime: doc.commentTime,
            commentLike: doc.commentLike,
            commentUserNM: doc.commentUserNM,
            comment: doc.comment,
            cLikeUsers: doc.cLikeUsers,
          ),
        )
        .toList();
  }
}
