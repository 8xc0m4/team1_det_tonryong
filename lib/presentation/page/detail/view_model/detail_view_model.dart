import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/detail_entity.dart';
import 'package:team1_det_tonryong/presentation/detail_provider.dart';

class DetailViewModel extends FamilyNotifier<List<DetailEntity>, String> {
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
}

final detailViewModelProvider =
    NotifierProvider.family<DetailViewModel, List<DetailEntity>, String>(
      () => DetailViewModel(),
    );
