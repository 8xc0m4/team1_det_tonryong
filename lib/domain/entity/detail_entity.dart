class DetailEntity {
  String feedId;
  String userNM;
  DateTime feedTime;
  String feedPhoto;
  List<String> fLikeUsers;
  List<String> cLikeUsers;
  List<String> comments;

  DetailEntity({
    required this.feedId,
    required this.userNM,
    required this.feedTime,
    required this.feedPhoto,
    required this.fLikeUsers,
    required this.cLikeUsers,
    required this.comments,
  });
}
