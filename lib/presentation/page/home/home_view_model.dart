import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/notification_helper.dart';
import 'package:team1_det_tonryong/presentation/page/comment/comment_page.dart';
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
    changeLike(title: '댓통령', content: '회원님의 댓글에 누군가가 좋아요를 눌렀습니다');
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

  // 여기에 댓글 변화를 확인 메서드
  Future<void> changeLike({
    required String title,
    required String content,
  }) async {
    // 메서드 안에서 로컬 알림 띄우는 로직 호출
    NotificationHelper.show('', '');
    if (title.isEmpty || content.isEmpty) return;
  }

  Future<void> loadMorePhoto() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    final getFeedUsecase = ref.read(getFeedsUsecaseProvider);
    final newResult = await getFeedUsecase.execute();
    if (newResult == null || newResult.isEmpty) {
      _hasMore = false;
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
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeState>(
      () {
        return HomeViewModel();
      },
    );
