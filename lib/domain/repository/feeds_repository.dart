import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/domain/entity/write_entity.dart';

abstract interface class FeedsRepository {
  Future<List<HomeEntity>?> getFeedsPhoto();
  Future<List<CommentEntity>> getComment(String id);
  Future<void> createFeed(WriteEntity feed);
}
