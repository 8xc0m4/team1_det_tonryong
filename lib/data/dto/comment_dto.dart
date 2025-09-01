import 'package:cloud_firestore/cloud_firestore.dart';

/// 피드에 대한 댓글 DTO 분리
class CommentDto {
  String commentId;
  DateTime commentTime;
  int commentLike;
  String commentUserNM;
  String comment;

  CommentDto({
    required this.commentId,
    required this.commentTime,
    required this.commentLike,
    required this.commentUserNM,
    required this.comment,
  });

  CommentDto.fromJson(String commentId, Map<String, dynamic> map)
    : this(
        commentId: commentId,
        commentTime: (map["commentTime"] as Timestamp).toDate(),
        commentLike: map["commentLike"],
        commentUserNM: map["commentUserNM"],
        comment: map["comment"],
      );
  Map<String, dynamic> toJson() {
    return {
      "commentTime": commentTime,
      "commentLike": commentLike,
      "commentUserNM": commentUserNM,
      "comment": comment,
    };
  }
}
