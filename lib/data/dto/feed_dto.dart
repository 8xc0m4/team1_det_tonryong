import 'package:cloud_firestore/cloud_firestore.dart';

class FeedDto {
  final String feedId;
  final String userNM;
  final DateTime feedTime;
  final int feedLike;
  final String feedPhoto;

  FeedDto({
    required this.feedId,
    required this.userNM,
    required this.feedTime,
    required this.feedLike,
    required this.feedPhoto,
  });
  FeedDto.fromJson(String feedId, Map<String, dynamic> map)
    : this(
        feedId: feedId,
        userNM: map["userNM"],
        feedTime: (map["feedTime"] as Timestamp).toDate(),
        feedLike: map["feedLike"],
        feedPhoto: map["feedPhoto"],
      );
  Map<String, dynamic> toJson() {
    return {
      "userNM": userNM,
      "feedTime": feedTime,
      "feedLike": feedLike,
      "feedPhoto": feedPhoto,
    };
  }
}
