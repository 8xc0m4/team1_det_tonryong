class FeedDto {
  final String userNM;
  final DateTime feedTime;
  final int feedLike;
  final String feedPhoto;
  final List<Comment> comments;

  FeedDto({
    required this.userNM,
    required this.feedTime,
    required this.feedLike,
    required this.feedPhoto,
    required this.comments,
  });
  FeedDto.fromJson(Map<String, dynamic> map)
    : this(
        userNM: map["userNM"],
        feedTime: map["feedTime"],
        feedLike: map["feedLike"],
        feedPhoto: map["feedPhoto"],
        comments: map["comments"],
      );
  Map<String, dynamic> toJson() {
    return {
      "userNM": userNM,
      "feedTime": feedTime,
      "feedLike": feedLike,
      "feedPhoto": feedPhoto,
      "comments": comments,
    };
  }
}

class Comment {
  String commentId;
  DateTime commentTime;
  int commentLike;
  String commentUserNM;

  Comment({
    required this.commentId,
    required this.commentTime,
    required this.commentLike,
    required this.commentUserNM,
  });

  Comment.fromJson(Map<String, dynamic> map)
    : this(
        commentId: map["commentId"],
        commentTime: map["commentTime"],
        commentLike: map["commentLike"],
        commentUserNM: map["commentUserNM"],
      );
  Map<String, dynamic> toJson() {
    return {
      "commentId": commentId,
      "commentTime": commentTime,
      "commentLike": commentLike,
      "commentUserN": commentUserNM,
    };
  }
}
