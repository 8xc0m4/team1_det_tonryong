class HomeEntity {
  String feedPhoto;
  String feedId;
  DateTime feedTime;
  List<String> fLikeUsers;
  String userNM;
  int feedLike;

  HomeEntity({
    required this.feedPhoto,
    required this.feedId,
    required this.feedTime,
    required this.fLikeUsers,
    required this.userNM,
    required this.feedLike,
  });
}
