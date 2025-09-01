class WriteEntity {
  final String userNM;
  final DateTime feedTime;
  final int feedLike;
  final String feedPhoto;
  final List<String> fLikeUsers;
  WriteEntity({
    required this.userNM,
    required this.feedTime,
    required this.feedLike,
    required this.feedPhoto,
    required this.fLikeUsers,
  });
}
