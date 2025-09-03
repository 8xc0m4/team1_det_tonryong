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
        .collection('feeds')
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
}
