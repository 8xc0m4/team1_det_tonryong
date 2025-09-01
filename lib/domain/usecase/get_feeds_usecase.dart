import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/domain/entity/write_entity.dart';
import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';

class GetFeedsUsecase {
  GetFeedsUsecase(this._feedsRepository);
  final FeedsRepository _feedsRepository;

  Future<List<HomeEntity>?> execute() async {
    return await _feedsRepository.getFeedsPhoto();
  }

  Future<List<CommentEntity>> executeComment(String id) async {
    return await _feedsRepository.getComment(id);
  }

  Future<void> executeCreateFeed(WriteEntity feed) async {
    await _feedsRepository.createFeed(feed);
  }
}
