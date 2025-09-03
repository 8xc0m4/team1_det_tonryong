import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';

class GetFeedsUsecase {
  GetFeedsUsecase(this._feedsRepository);
  final FeedsRepository _feedsRepository;

  Future<List<HomeEntity>?> execute({int page = 1}) async {
    return await _feedsRepository.getFeedsPhoto();
  }
}
