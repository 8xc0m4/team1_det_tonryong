import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
import 'package:team1_det_tonryong/data/dto/comment_dto.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

class FeedsDataSourceImpl implements FeedsDataSource {
  @override
  Future<List<FeedDto>?> getFeeds() async {
    final firestore = FirebaseFirestore.instance;
    final colRef = firestore.collection('feeds');
    final result = await colRef.get();
    final doc = result.docs
        .map(
          (e) => FeedDto.fromJson(
            e.id,
            e.data(),
          ),
        )
        .toList();
    return doc;
  }

  @override
  /// 피드에 대한 댓글 불러오기
  Future<List<CommentDto>> getComments(id) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final colRef = firestore.collection('feeds');
      final docRef = colRef.doc(id);
      final commentColRef = docRef.collection('comments');
      final result = await commentColRef.get();
      final doc = result.docs.map(
        (doc) {
          return CommentDto.fromJson(doc.id, doc.data());
        },
      ).toList();
      return doc;
    } catch (e) {
      // TODO: print Log로 바꾸는거 생각하기
      print(e);
      return List<CommentDto>.empty();
    }
  }
}
