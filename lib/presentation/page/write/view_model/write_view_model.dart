import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/write_entity.dart';
import 'package:team1_det_tonryong/presentation/providers.dart';

class WriteViewModel extends Notifier<WriteEntity> {
  @override
  build() {
    return WriteEntity(
      userNM: '',
      feedTime: DateTime.now(),
      feedLike: 0,
      feedPhoto: '',
      fLikeUsers: [],
    );
  }

  Future<void> fetchFeed(WriteEntity feed) async {
    final createFeed = ref.read(getFeedsUsecaseProvider);
    await createFeed.executeCreateFeed(feed);
  }
}

final writeViewModelProvider =
    NotifierProvider<WriteViewModel, WriteEntity>(
      () => WriteViewModel(),
    );
