class CommentEntity {
  final String commentId;
  final DateTime commentTime;
  final int commentLike;
  final String commentUserNM;
  final String comment;
  final List<String> cLikeUsers;

  CommentEntity({
    required this.commentId,
    required this.commentTime,
    required this.commentLike,
    required this.commentUserNM,
    required this.comment,
    required this.cLikeUsers,
  });
}
