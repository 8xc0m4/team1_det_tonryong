import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';

//
class DeleteFeedUsecase {
  final FeedsRepository repository;

  DeleteFeedUsecase(this.repository);

  Future<bool> execute(String id) {
    return repository.deleteFeed(id);
  }

  Future<void> call(String id) async {
    await repository.deleteFeed(id);
  } //
}
