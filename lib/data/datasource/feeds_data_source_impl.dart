import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team1_det_tonryong/data/datasource/feeds_data_source.dart';
import 'package:team1_det_tonryong/data/dto/comment_dto.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

class FeedsDataSourceImpl implements FeedsDataSource {
  DocumentSnapshot? _lastDoc;
  @override
  Future<List<FeedDto>?> getFeeds() async {
    final firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> colRef = firestore
        .collection('posts')
        .orderBy('feedLike', descending: true)
        .orderBy(FieldPath.documentId, descending: true)
        .limit(10);
    if (_lastDoc != null) {
      colRef = colRef.startAfterDocument(
        _lastDoc!,
      );
    }
    final result = await colRef.get();
    final doc = result.docs;
    if (doc.isNotEmpty) {
      _lastDoc = doc.last;
    }
    return doc
        .map(
          (e) => FeedDto.fromJson(e.id, e.data()),
        )
        .toList();
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

  // detail
  @override
  Future<FeedDto> getDetail(String id) async {
    final firestore = FirebaseFirestore.instance;
    final colRef = firestore.collection('feeds');
    final coldoc = colRef.doc(id);
    final result = await coldoc.get();
    final doc = FeedDto.fromJson(id, result.data()!);
    return doc;
  }
}
