import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
import 'package:team1_det_tonryong/domain/entity/detail_entity.dart';
import 'package:team1_det_tonryong/domain/repository/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  DetailRepositoryImpl(this._feedsDataSource);
  final FeedsDataSource _feedsDataSource;
  @override
  Future<DetailEntity> getDtailEntity(
    String id,
    String userNM,
  ) async {
    final feedsResult = await _feedsDataSource.getDetail(id);
    final commentResult = await _feedsDataSource.getComments(id);

    return DetailEntity(
      feedId: feedsResult.feedId,
      userNM: userNM,
      feedTime: feedsResult.feedTime,
      feedPhoto: feedsResult.feedPhoto,
      fLikeUsers: feedsResult.fLikeUsers,
      cLikeUsers: commentResult.,
      comments: [],
    );
  }
}

//엔티티 2개를 가져와서 함치는 것
