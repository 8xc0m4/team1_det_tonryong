import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
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
          (e) => HomeEntity(
            feedPhoto: e.feedPhoto,
            feedId: e.feedId,
            feedTime: e.feedTime,
            fLikeUsers: e.fLikeUsers,
            userNM: e.userNM,
            feedLike: e.feedLike,
          ),
        )
        .toList();
  }
}
