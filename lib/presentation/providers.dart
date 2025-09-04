import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
import 'package:team1_det_tonryong/data/datasource/feeds_data_source_impl.dart';
import 'package:team1_det_tonryong/data/repository/feeds_repository_impl.dart';
import 'package:team1_det_tonryong/domain/repository/feeds_repository.dart';
import 'package:team1_det_tonryong/domain/usecase/deleta_feed_usecase.dart';
import 'package:team1_det_tonryong/domain/usecase/get_feed_usecase.dart';
import 'package:team1_det_tonryong/domain/usecase/get_feeds_usecase.dart';

final _feedsDataSourceProvider = Provider<FeedsDataSource>(
  (ref) {
    return FeedsDataSourceImpl();
  },
);

final _feedsRepositoryProvider = Provider<FeedsRepository>(
  (ref) {
    return FeedsRepositoryImpl(
      ref.read(_feedsDataSourceProvider),
      FirebaseFirestore.instance,
    );
  },
);

final getFeedsUsecaseProvider = Provider(
  (ref) {
    return GetFeedsUsecase(ref.read(_feedsRepositoryProvider));
  },
);

final getFeedUsecaseProvider = Provider(
  (ref) {
    return GetFeedUsecase(ref.read(_feedsRepositoryProvider));
  },
);

final deleteFeedUsecaseProvider = Provider<DeleteFeedUsecase>((ref) {
  final refo = ref.watch(_feedsRepositoryProvider);
  return DeleteFeedUsecase(refo); //
});
