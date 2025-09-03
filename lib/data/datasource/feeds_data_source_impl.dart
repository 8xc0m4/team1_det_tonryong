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
}
