import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/detail_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/presentation/detail_provider.dart';

class DetailState {
  List<HomeEntity> getFeeds;

  DetailState({required this.getFeeds});
}

class DetailViewModel
    extends AutoDisposeFamilyNotifier<List<DetailEntity>, String> {
  @override
  List<DetailEntity> build(String feedId) {
    fetchDetail(feedId);
    return [];
  }

  Future<void> fetchDetail(String id) async {
    final getDetail = ref.read(detailUsecaseProvider);
    final result = await getDetail.execute(id);
    state = result;
  }

  Future<void> feedLikeUpdate({
    required String feedId,
    required bool liked,
    required String userNM,
  }) async {
    await ref
        .read(detailUsecaseProvider)
        .feedLikeUpdate(
          feedId: feedId,
          liked: liked,
          userNM: userNM,
        );
  }
}

final detailViewModelProvider = NotifierProvider.autoDispose
    .family<DetailViewModel, List<DetailEntity>, String>(
      () => DetailViewModel(),
    );
