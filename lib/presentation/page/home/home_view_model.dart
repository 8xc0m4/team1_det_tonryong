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
    return HomeState(getFeedsPhoto: []);
  }

  void loadPhoto() async {
    _hasMore = true;
    final getFeedsUsecase = ref.read(getFeedsUsecaseProvider);
    final result = await getFeedsUsecase.execute();

    state = HomeState(getFeedsPhoto: result ?? []);
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
        state = HomeState(getFeedsPhoto: [...state.getFeedsPhoto!, ...filter]);
      }
    }
    _isLoading = false;
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
