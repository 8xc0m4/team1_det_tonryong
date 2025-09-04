import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/presentation/providers.dart';

class HomeState {
  List<HomeEntity>? getFeedsPhoto;

  HomeState({required this.getFeedsPhoto});
}

class HomeViewModel extends Notifier<HomeState> {
  bool _isLoading = false;
  bool _hasMore = true;
  @override
  HomeState build() {
    loadPhoto();
    // 메서드 넣기
    return HomeState(getFeedsPhoto: []);
  }

  // 여기에 댓글 변화를 확인 메서드 <- 실시간 구독
  // 메서드 안에서 로컬 알림 띄우는 로직 호출

  void loadPhoto() async {
    _hasMore = true;
    final getFeedsUsecase = ref.read(getFeedsUsecaseProvider);
    final result = await getFeedsUsecase.execute();

    state = HomeState(getFeedsPhoto: result ?? []);
  }

  void refreshFeeds() async {
    loadPhoto(); // 삭제 후 새로고침
  }

  Future<void> loadMorePhoto() async {
    print("_로드모어 호출됨");
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    print("dkdkdkdk");
    final getFeedUsecase = ref.read(getFeedsUsecaseProvider);
    final newResult = await getFeedUsecase.execute();
    print("결과 : $newResult");
    if (newResult == null || newResult.isEmpty) {
      // _hasMore = false;
      print(_hasMore);
    } else {
      final exist = state.getFeedsPhoto!.map((e) => e.feedPhoto);
      final filter = newResult
          .where((e) => !exist.contains(e.feedPhoto))
          .toList();

      if (filter.isNotEmpty) {
        state = HomeState(
          getFeedsPhoto: [...state.getFeedsPhoto!, ...filter],
        );
      }
    }
    _isLoading = false;
  }

  // detail페이지에서 파이어베이스 삭제하기 때문에 List에서만 비워줌
  void deleteFeed(String feedId) {
    final newList = <HomeEntity>[];
    for (var i = 0; i < (state.getFeedsPhoto?.length ?? 0); i++) {
      if (state.getFeedsPhoto![i].feedId != feedId) {
        newList.add(state.getFeedsPhoto![i]);
      }
    }
    state = HomeState(getFeedsPhoto: newList);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
