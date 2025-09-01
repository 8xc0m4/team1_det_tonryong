class CommentEntity {
  DateTime commentTime;
  int commentLike;
  String commentUserNM;
  String comment;
  CommentEntity({
    required this.commentTime,
    required this.commentLike,
    required this.commentUserNM,
    required this.comment,
  });
}
